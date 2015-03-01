$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "discourse_mountable_sso/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "discourse_mountable_sso"
  s.version     = DiscourseMountableSso::VERSION
  s.authors     = ["Mohamed N.Salah"]
  s.email       = ["mohamednasser@usytech.com"]
  s.homepage    = "https://rubygems.org/gems/discourse_mountable_sso"
  s.summary     = "Discourse Mountable Sso is a mountable engine made to handle Discourse single sign on technique"
  s.description = "Discourse Mountable Sso is a mountable engine made to handle Discourse single sign on technique,it works with Rails 3.2.14"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 3.2', '>= 3.2.14'

end
