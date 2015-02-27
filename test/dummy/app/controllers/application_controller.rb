class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  protected
  def authenticate_user
  	unless session[:user_id]
  		redirect_to(:controller => 'sessions', :action => 'login')
  		return false
  	else
      # set current_user by the current user object
      	@current_user = User.find session[:user_id] 
  		return true
  	end
  end

  def get_discourse_data
    current_user = User.find session[:user_id] if session[:user_id]
    discourse_data = {}
    if current_user
      discourse_data[:avatar_url] = "http://ftp.lemoow.com/avatars/1/original/_D8_AC.jpg"
      discourse_data[:email] = current_user.email
      discourse_data[:name] = current_user.username
      discourse_data[:username] = current_user.username
      discourse_data[:external_id] = current_user.id
    end
    discourse_data
  end

	def logged_in?
		session[:user_id].present?
	end

	def return_to_url path
		session[:return_to] = path	
	end
	

  #This method for prevent user to access Signup & Login Page without logout
  def save_login_state
    if session[:user_id]
            redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end

end
