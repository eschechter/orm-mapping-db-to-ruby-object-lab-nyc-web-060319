class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    stud = Student.new
    stud.id = row[0]
    stud.name = row[1]
    stud.grade = row[2]
    stud
  end

  def self.find_by_name(name)
    # find the student in the database given a name

    sql = <<-SQL
    SELECT * FROM students WHERE name = ? LIMIT 1
    SQL
    row = DB[:conn].execute(sql, name)

    new_from_db(row.first)
  end

  def self.all_students_in_grade_9
    sql = <<-SQL
    SELECT * FROM students WHERE grade = 9 
    SQL

    rows = DB[:conn].execute(sql)

    rows.map do |row|
      new_from_db(row)
    end
  end

  def self.students_below_12th_grade
    sql = <<-SQL
    SELECT * FROM students WHERE grade < 12 
    SQL

    rows = DB[:conn].execute(sql)

    rows.map do |row|
      new_from_db(row)
    end
  end

  def self.all
    sql = <<-SQL
    SELECT * FROM students; 
    SQL

    rows = DB[:conn].execute(sql)

    rows.map do |row|
      new_from_db(row)
    end
  end

  def self.first_X_students_in_grade_10(x)
    sql = <<-SQL
    SELECT * FROM students 
    WHERE grade = 10 
    LIMIT ?;
    SQL

    rows = DB[:conn].execute(sql, x)

    rows.map do |row|
      new_from_db(row)
    end
  end

  def self.first_student_in_grade_10
    sql = <<-SQL
    SELECT * FROM students 
    WHERE grade = 10 
    LIMIT 1;
    SQL

    rows = DB[:conn].execute(sql)

    rows.map do |row|
      new_from_db(row)
    end.first
  end

  def self.all_students_in_grade_X(x)
    sql = <<-SQL
    SELECT * FROM students 
    WHERE grade = ?;
    SQL

    rows = DB[:conn].execute(sql, x)

    rows.map do |row|
      new_from_db(row)
    end
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
