require 'rubygems/package_task'

spec = Gem::Specification.new do |s|
  s.name                  = "rserver"
  s.summary               = "Barebones chat server"
  s.description           = File.read(File.join(File.dirname(__FILE__), 'README'))
  s.requirements          = []
  s.version               = '0.0.1'
  s.author                = "Ifeanyi Ubah"
  s.homepage              = "http://iffy.se"
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = '>=1.9'
  s.files                 = Dir['**/**']
  s.executables           = ['rserver']
  s.has_rdoc              = false
end

Gem::PackageTask.new(spec).define
