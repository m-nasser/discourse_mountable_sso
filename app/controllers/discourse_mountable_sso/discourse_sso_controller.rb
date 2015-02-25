require 'single_sign_on'

module DiscourseMountableSso

  class DiscourseSsoController < ApplicationController
    before_filter :authenticate_user # ensures user must login

    def sso
      free_return_to
      secret = "83IC~q<ITI#15n(6f515sw5crA?lF&"
      current_user = get_current_user 
      sso = request.query_string =="" ? SingleSignOn.parse(session[:discourse_mountable_sso][:query_string] , secret) : SingleSignOn.parse(request.query_string, secret)
      # binding.pry
      sso.email = current_user.email 
      sso.name = current_user.username 
      sso.username = current_user.email
      sso.external_id = current_user.id
      sso.sso_secret = secret

      redirect_to sso.to_url("http://local:4000//session/sso_login")
    end

    def authenticate_user
      # binding.pry
      # set_login_path request.referer
      if logged_in?
        return true
      else
        session[:discourse_mountable_sso] = { query_string: request.query_string}
        return_to_url request.path 
        redirect_to main_app.login_path
      end
    end  
  end
end