require 'socket'

class Server

#  Thread::abort_on_exception = true
  def initialize ip, port
    begin
      @server =  TCPServer.new ip, port
      @clients = {  }
      @connections = {  }
      @mutex = Mutex.new

      puts "Listening on #{ip} port #{port}"

      serve

    rescue Exception => e
      broadcast "EOF", nil
      puts "Exception => #{e.inspect}"
    end

  end
private
  def serve
    loop do
      socket = @server.accept
      Thread.new(socket) do |client|
        handle_client client
      end
    end
  end

  def client key
    val = nil
    @mutex.synchronize do
      val = @clients[key]
    end
    val
  end
  def handle_client socket
    already_joined = false
    while request_line = socket.gets.chomp! do
      # puts request_line
      if (match = /\Ajoin\s+(\w+)/.match request_line)
        begin
          handle_join socket, match[1]
          already_joined = true
        end unless already_joined
      elsif (match = /\Apubmsg\s+(.+)\s+(\w+)$/.match request_line)
        broadcast "pubmsg #{match[1]} #{match[2]}\n", match[2] if(socket == (client match[2]))
      elsif (match = /\Aprivmsg\s+(\w+)\s+(.+)\s+(\w+)$/.match request_line)
        nick_socket = client match[1]
        begin
          nick_socket.print "privmsg #{match[2]} #{match[3]}\n"
        end if nick_socket
      elsif (match = /\Alogout\s+(\w+)/.match request_line)
        nick_socket = client match[1]
        if nick_socket && nick_socket == socket
           @mutex.synchronize do
            @clients.delete match[1]
            @clients.each do|nick, skt|
              skt.print "list #{@clients.keys.join ' '}\n"
            end
          end

          puts "@#{@clients.inspect}"
          socket.print "003 Logout successful\n"
          Thread.kill self
        else
          socket.print "004 Logout unsuccessful\n"
        end
      elsif /\Alist$/  =~ request_line
        socket.print "list #{@clients.keys.join ' '}\n"
      else
        puts "unhandled request '#{request_line}'"
      end
    end
  end

  def handle_join socket,  nick
    if client nick
      socket.print "001 nickname taken\n"
    else
      @mutex.synchronize { @clients[nick] = socket }
      socket.print "002 join successful\n"
      broadcast "list #{@clients.keys.join ' '}\n", nil
      puts "New client joined: "+@clients.inspect
    end
  end
  def broadcast msg, exception
    @mutex.synchronize do
      @clients.each do |key, socket|
        socket.print msg if key != exception
      end
    end
  end
end
