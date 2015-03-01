module DiscourseMountableSso 
	class Configuration 
   		attr_accessor :secret, :discourse_url, :login_path, :discourse_data_method, :logged_in_check_method,
   		               :store_return_to_url_method
   		def initialize 
    		@login_path = "/login"
    		@discourse_data_method = "get_discourse_data"
    		@logged_in_check_method = "logged_in?" 
   		end
  	end 
end
