require 'net/ssh'

username = ''
password = ''

log = ''
hosts = []

filename = log.gsub(/^\//, '').gsub(/[\/ ]/, '_')
file = File.open("logs/#{filename}.log", 'w')
output = ''

hosts.each do |host|
  Net::SSH.start(host, username, password: password) do |ssh|
    output += ssh.exec!("[[ $(ls #{log} 2> /dev/null) ]] && cat #{log}")
  end
end

file.write(output)
