require 'csv'

module Julia
  class Builder
    attr_reader :collection, :csv_options

    def initialize(collection, csv_options = Hash.new)
      @collection, @csv_options = collection, csv_options
    end

    def self.column(keyname, action = nil, &block)
      columns_config[keyname] = Action.new(keyname, action, &block)
    end

    def self.columns(*args)
      args.each do |key|
        column(key)
      end
    end

    def self.columns_config
      @columns_config ||= {}
    end

    def build
      CSV.generate(csv_options) do |csv|
        csv << columns_config.keys

        collection.each do |record|
          csv << columns_config.values.map do |action|
            action.get_value(record, self)
          end
        end
      end
    end

    def self.build(collection, csv_options = Hash.new)
      new(collection, csv_options).build
    end

    protected

    def columns_config
      self.class.columns_config
    end
  end
end
