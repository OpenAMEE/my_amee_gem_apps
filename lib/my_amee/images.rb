require 'my_amee/app_config'

module ActionView
  module Helpers
    module AssetTagHelper
      def image_path_with_my_amee(source)
        return image_path_without_my_amee(source) if source =~ /^http.*/
        # Fetch config
        config = MyAmee::AppConfig.get(:theme)
        # If theme is set, get stylesheet url
        if config
          if source =~ /^\/.*/
            return "#{config['url']}#{source}"
          else
            return "#{config['url']}/images/#{source}"
          end
        else
          return image_path_without_my_amee(source)
        end
      end
      alias_method_chain :image_path, :my_amee
      alias_method :path_to_image, :image_path_with_my_amee
    end
  end
end
