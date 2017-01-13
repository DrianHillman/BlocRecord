require 'bloc_record/utility'
require 'bloc_record/schema'
require 'bloc_record/persistence'
require 'bloc_record/selection'
require 'bloc_record/connection'
require 'bloc_record/collection'
require 'bloc_record/associations'
 
module BlocRecord
  class Base
    include Persistence
    extend Selection
    extend Schema
    extend Connection
    extend Collection
    extend Associations
    
    def initialize(options={})
      options = BlocRecord::Utility.convert_keys(options)
 
      self.class.columns.each do |col|
        self.class.send(:attr_accessor, col)
        self.instance_variable_set("@#{col}", options[col])
      end
    end
  end
end