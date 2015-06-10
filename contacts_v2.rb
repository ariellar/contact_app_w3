require "pg"
require "pry"
require "irb"


class Contact
  
  attr_reader :id, :firstname, :lastname, :email
  
  def initialize(id, firstname, lastname, email)
    @conn = Connect.new.connecting
    @id = id
    @firstname = firstname
    @lastname = lastname
    @email = email
  end

  def to_s
    "#{firstname} #{lastname} #{email}"
  end

  def new_record?
    if @id.nil? 
    end
  end

  def save!
    if new_record?
        pg_result = @conn.exec_params(
          "INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3)",
          [firstname, lastname, email])
        # end
        to_array(pg_result)
    else
        pg_result = @conn.exec_params(
          "UPDATE contacts  SET firstname = $1, lastname = $2, email = $3",
          [firstname, lastname, email])
        # end
        to_array(pg_result)
    end
  end

  def destroy(id)
   pg_result = @conn.exec_params("DELETE FROM contacts WHERE id = $1", [id]) 
   to_array(pg_result)
  end
  
  class << self

    def find(id)
      pg_result = @conn.exec_params(
        "SELECT c.id, c.firstname, c.lastname, c.email
        FROM contacts AS c
        WHERE c.id = $1", [$1])
      to_array(pg_result) 
    end

    def find_all_by_firstname(firstname)
      pg_result = @conn.exec_params(
        "SELECT * FROM contacts WHERE firstname = $1", [firstname])
      to_array(pg_result)
    end

    def find_all_by_lastname(lastname)
      pg_result = @conn.exec_params("SELECT * FROM contacts WHERE lastname = $1", [lastname])
      to_array(pg_result)
    end

    def find_by_email(email)
      pg_result = @conn.exec_params("SELECT * FROM contacts WHERE email = $1", [email])
      to_array(pg_result)
    end

    def all 
      pg_result = Connect.new.connecting.('SELECT * FROM contacts')
      to_array(pg_result)
    end

    private 
    def to_array(pg_result)
      result = []
      pg_result.each do |row|
        result << Contact.new(row["id"], row["firstname"], row["lastname"], row["email"])
      end
      result
    end

  end

end
