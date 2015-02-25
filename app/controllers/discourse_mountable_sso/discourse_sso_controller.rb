require 'single_sign_on'

module DiscourseMountableSso

  class DiscourseSsoController < ApplicationController
    before_filter :authenticate_user # ensures user must login

    def sso
      secret = "83IC~q<ITI#15n(6f515sw5crA?lF&"
      current_user = get_current_user 
      sso = request.query_string =="" ? SingleSignOn.parse(session[:discourse_mountable_sso][:query_string] , secret) : SingleSignOn.parse(request.query_string, secret)
      # binding.pry
      sso.avatar_url = current_user.discourse_data[:avatar_url]
      sso.email = current_user.discourse_data[:email] 
      sso.name = current_user.discourse_data[:name] 
      sso.username = current_user.discourse_data[:email]
      sso.external_id = current_user.discourse_data[:id]
      sso.sso_secret = secret

      redirect_to sso.to_url(discourse_return_url)
    end

    def authenticate_user
      if logged_in?
        return true
      else
        session[:discourse_mountable_sso] = { query_string: request.query_string}
        return_to_url request.path 
        redirect_to login_path
      end
    end  
  end
end