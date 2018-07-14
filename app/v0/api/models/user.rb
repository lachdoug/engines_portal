class V0
  module Api
    module Models
      class User

        def initialize( session, request, settings )
          @session = session
          @request = request
          @settings = settings
        end

        def sign_in( system, params )
          dn = system.dn_lookup uid: params[:uid], password: params[:password]
          system_api_token = system.sign_in( {
            user_name: dn[:dn],
            password: params[:password],
            ip_address: @request.ip } )
          system.set_token( system_api_token )
          user_detail = system.api.show_users_account( params[:uid] )
          @session[:is_admin] = !!user_detail[:groups].find { |group| group[:dn] == "cn=administrators,ou=Groups,dc=engines,dc=internal" }
          @session[:system_api_token] = system_api_token
          @session[:timestamp] = Time.now.to_i
          @session[:uid] = params[:uid]
          @session[:dn] = dn[:dn]
          @session[:password] = params[:password]
          return system_api_token
        end

        def sign_out
          @session.clear
        end

        def user_name
          @session[:uid]
        end

        def password
          @session[:password] # store password for ldap binding
        end

        def authenticated?(opts={})
          force_sign_out "Not signed in." unless user_name && system_api_token
          check_timeout( opts )
          return true
        end

        def system_api_token
          @session[:system_api_token]
        end

        def signin_timeout?
          ( Time.now.to_i - @session[:timestamp].to_i ) > @settings.user_inactivity_timeout
        end

        def is_admin?
          @session[:is_admin]
        end

        def shortcuts
          @shortcuts ||= (
            AccountShortcut.where( account_uid: user_name ).map( &:shortcut ).sort_by { |v| v.label.downcase } +
            Shortcut.where( all_accounts: true ) ).uniq.sort_by { |shortcut| shortcut.label.downcase }
        end


        private

        def session_id
          @session[:tracking]["HTTP_USER_AGENT"]
        end

        def check_timeout( opts )
          force_sign_out "Signed out due to inactivity." if signin_timeout?
          refresh_timestamp unless opts[:skip_timeout_update]
        end

        def force_sign_out( message )
          sign_out
          raise NonFatalError.new message, 401
        end

        def refresh_timestamp
          @session[:timestamp] = Time.now.to_i
        end

      end
    end
  end
end
