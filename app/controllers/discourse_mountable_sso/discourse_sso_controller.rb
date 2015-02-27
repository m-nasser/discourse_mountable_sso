module DiscourseMountableSso
  require "discourse_mountable_sso/single_sign_on"
  class DiscourseSsoController < ApplicationController
    before_filter :authenticate_user # ensures user must login

    def sso
      secret = @config.secret  
      sso = request.query_string == "" ? DiscourseMountableSso::SingleSignOn.parse(session[:discourse_mountable_sso][:query_string] , secret) : DiscourseMountableSso::SingleSignOn.parse(request.query_string, secret)

      discourse_data = send @config.your_discourse_data_method
      discourse_data.each_pair {|k,v| sso.send("#{ k }=", v) }

      sso.sso_secret = secret 
      redirect_to sso.to_url("#{@config.your_discourse_url}"+"/session/sso_login")
    end

    def authenticate_user
      @config = DiscourseMountableSso.configuration

      if send @config.your_check_logged_in_method
        return true
      else
        session[:discourse_mountable_sso] = { query_string: request.query_string}
        
        send(@config.your_return_to_url,request.path)        
        redirect_to @config.your_server_login_path
      end
    end  
  end
end