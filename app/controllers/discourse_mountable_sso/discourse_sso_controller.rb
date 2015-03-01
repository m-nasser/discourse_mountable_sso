module DiscourseMountableSso
  class DiscourseSsoController < ApplicationController
    before_filter :load_configuration
    before_filter :authenticate_user # ensures user must login

    def sso
      require "discourse_mountable_sso/single_sign_on"
      
      sso = DiscourseMountableSso::SingleSignOn.parse(
        ((session[:discourse_mountable_sso] || {}).delete(:query_string).presence || request.query_string),
        @config.secret
      )

      discourse_data = send @config.discourse_data_method
      discourse_data.each_pair {|k,v| sso.send("#{ k }=", v) }

      sso.sso_secret = @config.secret
      redirect_to sso.to_url("#{@config.discourse_url}/session/sso_login")
    end

    protected

    def load_configuration
      @config = DiscourseMountableSso.configuration
    end

    def authenticate_user
      return true if send @config.logged_in_check_method
        
      session[:discourse_mountable_sso] = {query_string: request.query_string}
      send(@config.store_return_to_url_method, request.path)        
      redirect_to @config.login_path
    end  
  end
end