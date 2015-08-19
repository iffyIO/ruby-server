# A barebones chat server written in ruby.

Primarily a personal exercise while learning Ruby.  
Supports private and public messages between users.  
Public messages are broadcast to all connected clients,
Private messages are only sent to specified user

## Message format
### Client to server

#### Join request
*To join the chat server*
"join [nickname]"  
**where**  
  nickname = chosen nickname of user

#### Public message
"pubmsg [message] [sender]"  
**where**  
  message = message to be sent to all connected clients  
  sender  = nickname of user sending message

#### Private message
"privmsg [receiver] [message] [sender]"  
**where**  
  receiver = nickname of receiving user  
  message  = message to be sent to receiver  
  sender   = nickname of user sending message  

#### Logging out from server
"logout [user]"  
**where**  
  user = nickname of user of connected client  

#### Retrieve list of users currently online
"list"  


### From Server to Client
messages format from server  

#### Joining the server
"001 nickname taken"  
Failed to join chat server because the selected nickname is already in use currently  

#### "002 join successful"  
User is registered with server  

#### Receiving a public message
"pubmsg [message] [sender]"  
**where**  
  message = message broadcast to the chat room  
  sender  = nickname of user sending the message  

### Receiving a private message
"privmsg [message] [sender]"  
**where**  
  message = message broadcast to 'this' user  
  sender  = nickname of user sending the message  

### Recieving a list of users currently online
"list [user1 user2 user3 ...]"  
**where**  
  userx = nickname of a user currently online  
**example**   
  "list foo bar baz quz"  
  **where**  
    foo, bar, baz and qux are online  

### Logging out from server
"003 Logout successful"  
*received if logout request is successful*  
"004 Logout unsuccessful"  
*received if logout request is not successful*  


## Running the server
**cd to bin/**  

rserver [port] [address]  
**where**  
 port     = [optional] port number to host server [default value 2345]  
 address  = [optional] adress to host server [default address = localhost]  
**example**   
  "rserver 2345 localhost"  
  *runs server on local machine, port 2345*  
