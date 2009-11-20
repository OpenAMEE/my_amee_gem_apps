require 'my_amee/current_path'
require 'my_amee/amee'
require 'my_amee/stylesheets'
require 'my_amee/images'

ActionController::Base.send :include, MyAmee::CurrentPath