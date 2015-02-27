module DiscourseMountableSso 
	class Configuration 
   		attr_accessor :secret,:your_discourse_url,:your_server_login_path,:your_discourse_data_method,:your_check_logged_in_method,:your_return_to_url 
   		def initialize 
    		@your_server_login_path = "/login"
    		@your_discourse_data_method = "get_discourse_data"
    		@your_check_logged_in_method = "logged_in?" 
   		end
  	end 
end
