require 'pry'
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      );
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS students;
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES (?, ?);
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    sql2 = <<-SQL
      SELECT id FROM students ORDER BY id DESC LIMIT 1;
    SQL
    id = DB[:conn].execute(sql2)[0][0]
    @id = id
  end

  def self.create(attrs_hash)
    # (self.new(attrs_hash[:name], attrs_hash[:grade])).save
    i = self.new(attrs_hash[:name], attrs_hash[:grade])
    i.save
    i
  end

end
