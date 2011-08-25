require 'active_support/core_ext'
require 'my_amee/app_config'

module ActionView
  module Helpers
    module AssetTagHelper
      def stylesheet_path_with_my_amee(source)
        return stylesheet_path_without_my_amee(source) if source.starts_with?("http")
        # Fetch config
        config = MyAmee::AppConfig.get(:theme)
        # If theme is set, get stylesheet url
        if config
          extension = source =~ /^.*\.css/ ? "" : ".css"
          if source.starts_with? "/"
            return "#{config['url']}#{source}#{extension}"
          else
            return "#{config['url']}/stylesheets/#{source}#{extension}"
          end
        else
          return stylesheet_path_without_my_amee(source)
        end
      end
      alias_method_chain :stylesheet_path, :my_amee
      alias_method :path_to_stylesheet, :stylesheet_path_with_my_amee

      def stylesheet_link_tag_with_my_amee(*sources)
        # Fetch status
        status = MyAmee::AppConfig.get(:status)
        # Adjust sources
        if status == "STAGE"
          stylesheet_link_tag_without_my_amee (sources + ["#{MyAmee::Config.get['url']}/stylesheets/staging-template.css"]).flatten
        else
          stylesheet_link_tag_without_my_amee sources
        end
      end
      alias_method_chain :stylesheet_link_tag, :my_amee

    end
  end
end