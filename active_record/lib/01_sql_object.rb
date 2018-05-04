require 'byebug'
require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @table if @table
    table = DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    
    @table = table.map(&:to_sym)
  end

    
  def self.finalize!
    self.columns.each do |column|
      define_method("#{column}=") do |arg|
        attributes[column] = arg
      end
      define_method(column) do
        attributes[column]
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || "#{self.to_s.downcase}".pluralize
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    all_columns = self.class.columns
    params.each do |k,v|
      @k = k.to_sym
      raise "uknown attribute" unless all_columns.include?(@k)
      @k = v
      self.class.finalize!
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
  
  
end
