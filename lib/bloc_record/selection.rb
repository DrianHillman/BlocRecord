require 'sqlite3'
 
module Selection
  def find(id)
    row = connection.get_first_row <<-SQL
      SELECT #{columns.join ","} FROM #{table}
      WHERE id = #{id};
    SQL
 
    data = Hash[columns.zip(row)]
    new(data)
  end
end