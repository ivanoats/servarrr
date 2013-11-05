require 'socket'

server = TCPServer.new 1337
puts "Preparrr the cannon on port 1337"

loop do
  client = server.accept
  request = client.gets
  puts request
  begin
    path = request.split(" ")[1]
    path = File.join("public", path)
    File.open(path, "r") do |file|
      puts "found the file: #{path}"
      client.puts "HTTP/1.1 200 OK"
      client.puts "Content-Type: text/html"
      client.puts "Content-Length: #{file.size}"
      client.puts "Connection: close"
      client.puts
      client.puts file.read
    end
  rescue Exception => e
    puts "there was an error: #{e.inspect}"
  end

  client.close
end
