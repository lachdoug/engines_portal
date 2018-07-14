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

        def set_token( token )
          @engines_api = nil
          @api = nil
          @token = token
        end

        def engines_api
          @engines_api ||= Services::EnginesApi.new( @url, @token, @settings, @session )
        end

        def api
          @api ||= engines_api.system
        end

        def sign_in(params)
          api.sign_in( {
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
          api.dn_lookup params
        rescue NonFatalError => e
          if e.status_code == 401
            raise NonFatalError.new "Invalid username or password.", 401
          else
            raise
          end
        end

        def apps
          api.app_statuses.keys.sort
        end

        def label_for(app_name)
          blueprint = api.blueprint_for app_name
          label = blueprint[:metadata] &&
          blueprint[:metadata][:display] &&
          blueprint[:metadata][:display][:label]
          label || app_name
        end

        def websites_for(app_name)
          api.websites_for app_name
        end

        def icon_url_for( app_name )
          api.icon_url_for app_name
        end

        def accounts
          @accounts ||= Accounts.new self
        end

        def email_addresses
          # @email_addresses ||= EmailAddresses.new self
          api.index_email_email_addresses
        end

        def distribution_groups
          @distribution_groups ||= DistributionGroups.new self
        end

        def email
          # @email ||= Email.new self
          api.show_email
        end

      end
    end
  end
end
