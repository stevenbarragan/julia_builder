require 'csv'

module Julia
  class Builder
    attr_reader :collection, :csv_options

    def initialize(collection, csv_options = Hash.new)
      @collection, @csv_options = collection, csv_options
    end

    def self.columns
      @columns ||= {}
    end

    def self.column(keyname, action = nil)
      self.columns[keyname] = action
    end

    def build
      CSV.generate(csv_options) do |csv|
        csv << columns.keys

        collection.each do |record|
          csv << columns.map do |key, action|
            get_value(record, key, action)
          end
        end
      end
    end

    protected

    def get_value(record, key, action)
      return record.instance_exec(&action) if action.is_a?(Proc)

      record.send([action, key].compact.first)
    end

    def columns
      self.class.columns
    end
  end
end
