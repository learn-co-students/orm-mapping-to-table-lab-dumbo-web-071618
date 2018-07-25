class Student
  # Student attributes should have an attr_accessor for name and grade
  attr_accessor :name, :grade
  # but only an attr_reader for id.
  attr_reader :id
  # Your Student instances should initialize with a name, grade and an optional
  # id.
  def initialize(name, grade, id=nil) # The default value of the id argument
  # should be set to nil.
    @id = id
    @name = name
    @grade = grade
    # The only place id can be set equal to something is inside the initialize
    # method, via: @id = some_id
  end
  # This is a class method that creates the students table.
  def self.create_table
    # Use a heredoc to set a variable, sql, equal to the necessary SQL statement
    sql =  <<-SQL
      -- Remember, the attributes of a student, name, grade, and id, should
      -- correspond to the column names you are creating in your students table.
      CREATE TABLE IF NOT EXISTS students (
        -- The id column should be the primary key.
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
    SQL
    # Remember, you can access your database connection anywhere in this class
    # with DB[:conn]
    DB[:conn].execute(sql)
    # With your sql variable pointing to the correct SQL statement, you can
    # execute that statement using the #execute method provided to us by the
    # SQLite3-Ruby gem. Remember that this method is called on whatever object
    # stores your connection to the database, in this case DB[:conn].
  end
  # This is a class method that drops the students table.
  def self.drop_table
    # Once again, create a variable sql, and set it equal to the SQL statement
    # that drops the students table.
    sql =  <<-SQL
      -- Remember, the attributes of a student, name, grade, and id, should
      -- correspond to the column names you are creating in your students table.
      DROP TABLE students;
      )
    SQL
    # Execute that statement against the database
    DB[:conn].execute(sql)
  end
  # This is an instance method that saves the attributes describing a given
  # student to the students table in our database.
  def save
    # Once again, create a variable, sql, and set it equal to the SQL statement
    # that will INSERT the correct data into the table.
    sql = <<-SQL
      INSERT INTO students (name, grade)
      -- Use bound paremeters to pass the given student's name and grade into
      -- the SQL statement.
      VALUES (?, ?)
    SQL
    # Remember that you don't need to insert a value for the id column.
    DB[:conn].execute(sql, self.name, self.grade)
    # However, at the end of your #save method, you do need to grab the ID of
    # the last inserted row, i.e. the row you just inserted into the database,
    # and assign it to the be the value of the @id attribute of the given
    # instance.
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
  # This is a class method that uses keyword arguments. The keyword arguments
  # are name: and grade:
  def self.create(name:, grade:) # Use the values of these keyword arguments to:
    # 1) instantiate a new Student object with Student.new(name, grade)
    student = Student.new(name, grade)
    # 2) save that new student object via student.save.
    student.save
    # The #create method should return the student object that it creates.
    student
  end
end
