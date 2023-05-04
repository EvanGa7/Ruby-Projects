#rubyex2.rb - create a roster class
#Evan Gardner
#s1270495
#CS-371
#Spring 2023

class Student
    def initialize( first, last, email )
       @first = first
       @last  = last
       @email = email
    end
 
    def show
       puts "#{@first}  #{@last}  #{@email}"
    end
end

class Roster
    def initialize
        @students = []  #here we start an empty array
    end

    def add_student(student)
        # @students << student #add a student to the array
        # @students.push(student) #add a student to the array
        @students.append(student) #add a student to the array
    end

    def show 
        @students.each do |student|
            student.show    #use the student class show method
        end
    end
end #Roster

# Test the above classes

# create a roster object
cs001 = Roster.new

#read roster.txt from $STDIN
for student in $stdin.readlines do 
    last, first, email = student.split(/\s*,\s*/)
    
    #construct student object
    student_obj = Student.new(first, last, email)
    cs001.add_student(student_obj)
end

#show the roster
cs001.show