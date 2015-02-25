require 'single_sign_on'

module DiscourseMountableSso

  class DiscourseSsoController < ApplicationController
    before_filter :authenticate_user # ensures user must login

    def sso
      secret = "83IC~q<ITI#15n(6f515sw5crA?lF&"
      current_user = get_current_user 
      sso = request.query_string =="" ? SingleSignOn.parse(session[:discourse_mountable_sso][:query_string] , secret) : SingleSignOn.parse(request.query_string, secret)
      # binding.pry
      sso.email = current_user.email 
      sso.name = current_user.name 
      sso.username = current_user.email
      sso.external_id = current_user.id
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