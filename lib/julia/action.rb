module Julia
  class Action
    attr_reader :key, :action, :block

    def initialize(key, action, &block)
      @key    = key
      @action = action
      @block  = block
    end

    def get_value(record)
      return block.call(record) if block
      return record.instance_exec(&action) if action.is_a? Proc

      record.send [action, key].compact.first
    end
  end
end
