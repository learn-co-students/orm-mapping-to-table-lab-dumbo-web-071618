class Student
  attr_accessor :name,:grade
  attr_reader :id

  def initialize name,grade,id = nil
    @name = name
    @grade = grade
    @id = id
  end

  # def initialize attributes
  #   attributes.each do |key,value|
  #     self.send("#{key}=",value)
  #   end
  # end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
    SQL

    DB[:conn].execute sql
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL

    DB[:conn].execute sql
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name,grade) VALUES (?,?)
    SQL

    DB[:conn].execute sql, @name, @grade

    @id = DB[:conn].execute("SELECT * FROM students ORDER BY id DESC LIMIT 1")[0][0]

    # binding.pry

  end

  def self.create attributes

    new_student = Student.new attributes[:name],attributes[:grade]
    new_student.save
    new_student
  end

end
