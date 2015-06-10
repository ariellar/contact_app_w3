require_relative 'connect'
require_relative 'contacts_v2'


def list
  contacts = Contacts.all 
  contacts.each do |contact| 
    puts "ID: #{contact.id} First Name: #{contact.firstname} Last Name: #{contact.lastname} Email: #{contact.email}"
  end
end

def create_update
  if Contact.new_record? == false 
    print "This contact already exists"
  else
    print "Enter first name: "
    firstname = gets.chomp
    print "Enter last name: "
    lastname = gets.chomp
    print "Enter email: "
    email = gets.chomp

    contact = Contact.new(nil, firstname, lastname, email)

    contact.save!
  end
  create

# self.new
end


def update
  puts "Enter the id of the contact you want to edit"
  contact_id = gets.chomp.to_i
  contact = Contact.find(contact_id)
  print "Enter a new first name: "
  new_firstname = gets.chomp 
  print "Enter a new last name: "
  new_lastname = gets.chomp
  contact.firstname = new_firstname
  contact.lastname = new_lastname
  contact.save!
end

def find
  print "Find a contact based on their - id, firstname, lastname, or email? "
  find_by = gets.chomp.downcase
  print "Enter a particular id, firstname, lastname, or email you would like to find: "
  attrib = gets.chomp
  case find_by.downcase
    when "id"
      Contact.find(attrib)
    when "firstname"
      Contact.find_all_by_firstname(attrib)
    when "lastname"
      Contact.find_all_by_lastname(attrib)
    when "email"
      Contact.find_by_email(attrib) 
    else
      puts "Sorry I didn't get that"
  end 

end

def destroy
  list
  print "Which id number would you like deleted?"
  id_to_delete = gets.chomp
  contact_string = show(id_to_delete)
  Contact.destroy(id_to_delete)
  puts "Contact deleted: #{contact_string}"
end



loop do
  print %q(
    Menu

    new - create new contact
    destroy - delete a contact based on id
    list - show all contacts
    find - based on an id
    find by email - find contacts based on email
    find all by lastname - find all contacts with a particular last name
    find all by firstname - find all contacts with a particular first name
    update - update a contact based on id
    quit - exit program
     > )

  command = gets.chomp

  case command.downcase

  when "create"
    Contact.create
  when "destroy"
    Contact.destroy
  when "list"
    Contact.list
  when "find"
    Contact.find
  when "update"
    Contact.update
  when "quit"
    puts "Closing connecttion"
    @conn.close
    break
  end 
end



    
  