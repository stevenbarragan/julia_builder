module Julia
  class Action
    attr_reader :key, :action, :block

    def initialize(key, action = nil, &block)
      @action = action
      @block  = block
      @key    = key
    end

    def get_value(record, host)
      return host.instance_exec(record, &block) if block
      return record.instance_exec(&action) if action.is_a? Proc

      record.send [action, key].compact.first
    end
  end
end
