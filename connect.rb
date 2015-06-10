require 'pg'
require 'pry'
require 'irb'

class Connect
  def connecting
    puts "establishing connection ..."
    begin
      return PG.connect(
        dbname: 'contactsv2',
        port: 5432,
        user: 'development',
        host: 'localhost',
        password: 'development'
      )
    rescue PG::ConnectionBad
      p $!
      puts "Sorry there is something wrong with your credentials"
    end
    puts "Connected to database."
  end
end



