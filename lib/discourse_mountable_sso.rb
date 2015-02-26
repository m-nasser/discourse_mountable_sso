require "discourse_mountable_sso/engine"
require "discourse_mountable_sso/configuration"

module DiscourseMountableSso
	def self.configuration
		@configuration ||= Configuration.new
	end 
end
