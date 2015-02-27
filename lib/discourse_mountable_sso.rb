require "discourse_mountable_sso/engine"
require "discourse_mountable_sso/configuration"

module DiscourseMountableSso
	attr_writer :configuration
	
	def configuration
		@configuration ||= Configuration.new
	end
	module_function :configuration
end
