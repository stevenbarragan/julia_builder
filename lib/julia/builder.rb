require 'csv'

module Julia
  class Builder
    attr_reader :collection, :csv_options

    def initialize(collection, csv_options = Hash.new)
      @collection, @csv_options = collection, csv_options
    end

    def self.column(keyname, action = nil, &block)
      self.columns[keyname] = Action.new(keyname, action, &block)
    end

    def self.columns
      @columns ||= {}
    end

    def build
      CSV.generate(csv_options) do |csv|
        csv << columns.keys

        collection.each do |record|
          csv << columns.values.map do |action|
            action.get_value(record)
          end
        end
      end
    end

    def self.build(collection, csv_options = Hash.new)
      new(collection, csv_options).build
    end

    protected

    def columns
      self.class.columns
    end
  end
end
