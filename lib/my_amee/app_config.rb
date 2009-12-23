require 'my_amee/config'
require 'my_amee/current_path'
require 'my_amee/exceptions'
require "net/http"
require 'json'

module MyAmee
  class AppConfig

    def self.get(section)
      path = ENV['MY_AMEE_PATH'] || MyAmee::CurrentPath.get
      if path
        # Load appstore config from YAML
        config = MyAmee::Config.get
        if config && config['secret_key'] && config['url']
          # Generate configuration URL
          url = URI.parse("#{config['url']}/apps.json?app=#{config['secret_key']}&path=#{path}")
          # Get configuration from appstore
          appconf = JSON.parse(Net::HTTP.get(url))
          raise MyAmee::Exceptions::Suspended.new("suspended") if appconf['status'] == "SUSPENDED"
          raise MyAmee::Exceptions::Initialising.new("not yet initialised") if appconf['status'] == "INITIALISING"
          return appconf[section.to_s]
        end
      end
      nil
    end
    
  end
end
