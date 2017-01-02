require 'sqlite3'
require 'bloc_record/utility'
 
module Schema
  def table
    BlocRecord::Utility.underscore(name)
  end
  
  def columns
    schema.keys
  end
  
  def attributes
    columns - ["id"]
  end
  
  #This method uses the lazy loading design pattern, which means @schema isn't calculated until the first time it is needed.
  def schema
    unless @schema
      @schema = {}
      connection.table_info(table) do |col|
        @schema[col["name"]] = col["type"]
      end
    end
    @schema
  end
  
  def count
    connection.execute(<<-SQL)[0][0]
      SELECT COUNT(*) FROM #{table}
    SQL
  end
end