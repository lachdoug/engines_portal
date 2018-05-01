class V0
  module Api
    module Models
      class System

        def initialize(url, token, settings, session)
          @url = url
          @token = token
          @settings = settings
          @session = session
        end
        attr_reader :url

        def engines_api
          @engines_api ||= Services::EnginesApi.new( @url, @token, @settings, @session )
        end

        def engines_api_system
          @engines_api_system ||= engines_api.system
        end

        def sign_in(params)
          engines_api_system.sign_in( {
            user_name: params[:user_name],
            password: params[:password],
            ip_address: params[:ip_address]
          } )
        rescue NonFatalError => e
          # cusotmize error messages for signin
          if e.status_code == 401
            raise NonFatalError.new "Invalid username or password.", 401
          elsif e.status_code == 502
            raise NonFatalError.new "Failed to connect to system.\n\nPlease check that the system is running and accessable on the network at the URL provided.", 502
          else
            raise e
          end
        end

        def dn_lookup(params)
          engines_api_system.dn_lookup params
        rescue NonFatalError => e
          if e.status_code == 401
            raise NonFatalError.new "Invalid username or password.", 401
          else
            raise
          end
        end

      end
    end
  end
end
