require 'my_amee/exceptions'

module MyAmee

  module ErrorHandlers
    def self.included(base)
      base.class_eval do
        before_filter :check_myamee_status
        alias_method_chain :rescue_action_in_public, :myamee
      end
    end

    def check_myamee_status
      status = MyAmee::AppConfig.get(:status)
      raise MyAmee::Exceptions::Suspended.new("suspended") if status == "SUSPENDED"
      raise MyAmee::Exceptions::Initialising.new("not yet initialised") if status == "INITIALISING"
    end

    def rescue_action_in_public_with_myamee(exception)
      case exception
      when MyAmee::Exceptions::Suspended, MyAmee::Exceptions::Initialising
        render :file => File.dirname(__FILE__)+"/../../templates/503.html", :code => 503
      else
        rescue_action_in_public_without_myamee(exception)
      end
    end

  end

end