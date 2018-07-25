class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  attr_accessor   :name, :grade
  attr_reader :id
  
  def  initialize(name,grade, id=nil)
    @name = name
    @grade = grade 
    @id = id
    
    
  end 
  
  def self.create_table
    sql = "CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, grade INTEGER);"
  DB[:conn].execute(sql)
    
  end 
  
  
  def self.drop_table
     sql = "DROP TABLE  students;"
     DB[:conn].execute(sql)
    
  end 
  
  
 #def save
    #sql  =  "INSERT INTO students(name,grade) VALUES(?,?);"
    #DB[:conn].execute(sql, self.name, self.grade)
    #puts "this is the data  #{a}"
    
    
     #sql_id = "SELECT id FROM students WHERE id=?;"
    #ans = DB[:conn].execute(sql_id, self.id)
    # puts "This is the name #{self.name}"
     #puts "This is the name #{self.grade}"
    # puts "This is the name #{self.id}"
    #puts "thhis is the sql id #{ans}"
  #end
  
  def save
    sql = 
      "INSERT INTO students (name, grade)
      VALUES (?, ?)
    ;"
    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute('SELECT * FROM students').flatten.first
  end
  
  
  def self.create(name:, grade:)
    student = Student.new(name,grade)
    student.save
    return student
    
    
  end 
  
  
  
end
