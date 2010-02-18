module MyAmee
  module CurrentHost
    def self.included(base)
      base.class_eval do
        before_filter :set_current_host
      end
    end

    def set_current_host
      Thread.current[:current_host] = request.host
    end

    def self.get
      Thread.current[:current_host]
    end 
  end
end