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
            dn: dn,
            password: params[:password],
            ip_address: @request.ip } )
          @session[:system_api_token] = system_api_token
          @session[:timestamp] = Time.now.to_i
          @session[:uid] = params[:uid]
          @session[:dn] = dn
          @session[:password] = params[:password]
          return system_api_token
        end

        def sign_out
          @session.clear
        end

        def user_name
          @session[:user_name]
        end

        def password
          @session[:password] # store password for ldap binding
        end

        def authenticated?(opts={})
          force_sign_out "Not signed in." unless system_api_token
          check_timeout( opts )
          return true
        end

        def system_api_token
          @session[:system_api_token]
        end

        def signin_timeout?
          ( Time.now.to_i - @session[:timestamp].to_i ) > @settings.user_inactivity_timeout
        end

        private

        def session_id
          @session[:tracking]["HTTP_USER_AGENT"]
        end

        # def populate_session(new_system_api_token)
        #
        # end

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


# class V0
#   module Api
#     module Models
#       class User
#
#         # attr_reader :username
#
#         def initialize( session, request, settings )
#           @session = session
#           @request = request
#           @settings = settings
#           FileUtils.touch "#{@settings.data_directory_path}/current_user.json"
#         end
#
#         def profile
#           Profile.first user_name: user_name
#         end
#
#         def sign_in( system, params )
#           api_token = system.sign_in( { user_name: params[:user_name], password: params[:password], ip_address: @request.ip } )
#           save_current_user params[:user_name], api_token
#         end
#
#         def sign_out
#           save_current_user(nil)
#         end
#
#         def authenticated?(opts={})
#           current_user_tokens.any?.tap do |signed_in|
#             if signed_in
#               force_sign_out "Signed out due to inactivity." if signin_timeout?
#               force_sign_out "Signed out due to sign in from another IP address." if request_not_from_original_ip_address?
#               force_sign_out "Signed out due to sign in from another session." if request_not_from_original_session?
#               refresh_timestamp unless opts[:skip_timeout_update]
#             else
#               force_sign_out "Not signed in."
#             end
#           end
#         end
#
#         def request_not_from_original_session?
#           session_id != stored_session_id
#         end
#
#         def user_name
#           current_user_tokens[:user_name]
#         end
#
#         def system_api_token
#           current_user_tokens[:system_api_token]
#         end
#
#         def signin_timeout?
#           ( Time.now.to_i - current_user_tokens[:timestamp].to_i ) > @settings.user_inactivity_timeout
#         end
#
#         def request_not_from_original_ip_address?
#           # byebug
#           @request.ip != current_user_tokens[:ip_address]
#         end
#
#         private
#
#         def session_id
#           @session[:tracking]["HTTP_USER_AGENT"]
#         end
#
#         def save_current_user(user_name, new_system_api_token=nil)
#           File.write "#{@settings.data_directory_path}/current_user.json",
#            new_system_api_token ? {
#              user_name: user_name,
#              system_api_token: new_system_api_token,
#              session_id: session_id,
#              timestamp: Time.now.to_i,
#              ip_address: @request.ip
#            }.to_json : ""
#         end
#
#         def current_user_tokens
#           current_user_tokens_file = File.read "#{@settings.data_directory_path}/current_user.json"
#           @current_user_tokens ||=
#           begin
#             JSON.parse ( current_user_tokens_file ), symbolize_names: true
#           rescue
#             {}
#           end
#         end
#
#         def stored_session_id
#           current_user_tokens[:session_id]
#         end
#
#         def force_sign_out( message )
#           sign_out
#           raise AuthError.new message, 401
#         end
#
#         def refresh_timestamp
#           File.write "#{@settings.data_directory_path}/current_user.json",
#             current_user_tokens.merge({ timestamp: Time.now.to_i }).to_json
#         end
#
#       end
#     end
#   end
# end
