require 'mysql'
begin
  con = Mysql.new 'localhost', 'root', 'dinesh 770'
  con.query("CREATE DATABASE IF NOT EXISTS usershare") 
rescue Mysql::Error => e
  puts e.errno
  puts e.error
ensure
  con.close if con
end