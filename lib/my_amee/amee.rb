require 'my_amee/app_config'

if Object.const_defined?("AMEE")

  module AMEE
    module Rails
      class Connection

        def self.global_with_my_amee(options = {})
          # Blow away the cached connection, so that we always force a reconnect with new credentials
          @connection = nil
          self.global_without_my_amee(options)
        end

        def self.connect_with_my_amee(server, username, password, options)
          # Fetch config
          config = MyAmee::AppConfig.get(:amee)
          # Connect to AMEE with credentials from My AMEE app config
          if config
            return connect_without_my_amee(config['server'], config['username'], config['password'], options)
          else
            return connect_without_my_amee(server, username, password, options)
          end
        end

        class << self
          alias_method_chain :global, :my_amee
          alias_method_chain :connect, :my_amee
        end

      end
    end
  end

end
