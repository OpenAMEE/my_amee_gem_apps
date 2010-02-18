require 'my_amee/current_host'
require 'my_amee/current_path'
require 'my_amee/error_handlers'
require 'my_amee/amee'
require 'my_amee/stylesheets'
require 'my_amee/images'

ActionController::Base.send :include, MyAmee::CurrentHost
ActionController::Base.send :include, MyAmee::CurrentPath
ActionController::Base.send :include, MyAmee::ErrorHandlers