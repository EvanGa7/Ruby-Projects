#rubyex3.rb - Ruby and SQLite example
#Evan Gardner
#s1270495
#CS-371
#Spring 2023

require 'rubygems'
require 'sqlite3'
    # Note that single quotes are required when loading ruby modules
    # RubyGems and the SQLite3 interface for Ruby packages must be
    # installed on the system.

$db = SQLite3::Database.new("dbfile")
    # $db is global variable and db object
$db.results_as_hash = true
    # forces SQLite to return data in a hash format rather than as an
    # array of attributes



# Note: Ruby methods have to be defined before they are used. So they
# normally belong at the top of a program.
#
def disconnect_and_quit
    $db.close
    puts "Bye!"
    exit
end


def create_table
    puts "Creating people table"
    $db.execute %q{
        CREATE TABLE people (
        id integer primary key,
        name varchar(50),
        job varchar(50),
        gender varchar(6),
        age integer)
    }
        # %q - multi-line string object
        # $db.execute - use DB to execute the following SQL statements
end



def add_person
    puts "Enter name:"
    name = gets.chomp
        # gets is the complement of 'puts'
        # Ruby equivalent of chomp
    puts "Enter job:"
    job = gets.chomp
    puts "Enter gender:"
    gender = gets.chomp
    puts "Enter age:"
    age = gets.chomp
    $db.execute("INSERT INTO people (name, job, gender, age) VALUES (?, ?, ?, ?)", name, job, gender, age)
        # ?, ?, ?, ? are "placeholders" for values in name, job,
        # gender, age
end



def find_person
    puts "Enter name or ID of person to find:"
    id = gets.chomp

    person = $db.execute("SELECT * FROM people WHERE name = ? OR id = ?", id, id.to_i).first
    
    unless person
        puts "No result found"
        return
    end

    puts %Q{Name: #{person['name']}
Job: #{person['job']}
Gender: #{person['gender']}
Age: #{person['age']}}
    # There's a reason for this lack of indentation.
end


def list_all
    puts "Listing all persons in database:"

    everyone = $db.execute("SELECt * FROM people")
    puts everyone.class # Array of hashes
    unless everyone 
        puts "No results found"
        return
    end

    everyone.each do |record_hash|
        record_hash.each do |key, value|
            puts "#{key} : #{value}"
        end
        puts     # Extra newline between recods
    end
end # list_all


# Integrate it with a main routine that acts as a menu system for the
# four methods above.

loop do
    puts %q{Please select an option:

        1. Create people table
        2. Add a person
        3. Look for a person
        4. List all persons
        5. Quit}

    # Ruby version of case
    case gets.chomp
        when '1'
            create_table
        when '2'
            add_person
        when '3'
            find_person
        when '4'
            list_all
        when '5'
            disconnect_and_quit
    end
end
