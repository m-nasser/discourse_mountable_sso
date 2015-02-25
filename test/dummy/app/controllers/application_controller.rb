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

	def logged_in?
		session[:user_id].present?
	end

	def return_to_url path
		session[:return_to] = path	
	end

  def free_return_to
    session[:return_to] = nil
  end
	
  def get_current_user 
		User.find session[:user_id]
	end

  def set_login_path url
    session[:discourse_mountable_sso] = {login_path: url+"session/sso_login"}    
  end

  def login_url
    session[:discourse_mountable_sso][:login_path]
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
