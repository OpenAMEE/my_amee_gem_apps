Gem::Specification.new do |s|
  s.name = "my_amee_apps"
  s.version = "1.0.0"
  s.date = "2009-11-20"
  s.summary = "Rails plugin to help integrate apps into my.amee.com"
  s.email = "james@amee.cc"
  s.homepage = "http://my.amee.com"
  s.has_rdoc = true
  s.authors = ["James Smith"]
  s.files = ["README", "COPYING"] 
  s.files += ['lib/my_amee/amee.rb', 'lib/my_amee/app_config.rb', 'lib/my_amee/stylesheets.rb', 'lib/my_amee/images.rb', 'lib/my_amee/current_path.rb']
  s.files += ['init.rb', 'rails/init.rb', 'lib/my_amee_apps.rb']
  s.files += ['lib/active_record/connection_adapters/my_amee_adapter.rb', 'lib/active_record/connection_adapters/nulldb_adapter.rb']
  s.files += ['bin/my_amee_extract_theme']
  s.executables = ['my_amee_extract_theme']
  s.add_dependency("my_amee_core", ">=1.0.0")
  s.add_dependency("json")
  s.add_dependency("amee", ">=2.0.28")
end
