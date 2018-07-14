class V0
  module Api
    module Services
      class EnginesApi
        class System

          def initialize(system_api)
            @system_api = system_api
            @session = system_api.session
          end

          def sign_in( params )
            @system_api.post 'system/login',
            {
              user_name: params[:user_name],
              password: params[:password],
              ip_address: params[:ip_address]
            },
            { timeout: 5 }
          end

          def dn_lookup( params )
            @system_api.post 'system/uadmin/dn_lookup',
            user_auth: {
              uid: params[:uid],
              password: params[:password]
            }
          end

          def call( method, route, params={} )
            @system_api.send( method, route, params )
          end

          ##########################################################################
          # Users > accounts
          ##########################################################################

          def index_users_accounts
            call :get, 'system/uadmin/users/accounts'
          end

          def show_users_account( uid )
            call :get, 'system/uadmin/users/accounts/', uid: uid
          end

          def create_users_account( account )
            # byebug
            call :post, 'system/uadmin/users/accounts/', account: account
          end

          def update_users_account( uid, account )
            call :put, 'system/uadmin/users/accounts/', uid: uid, account: account
          end

          def delete_users_account( uid )
            call :delete, 'system/uadmin/users/accounts/', uid: uid
          end

          ##########################################################################
          # Users > groups
          ##########################################################################

          def index_users_groups
            call :get, 'system/uadmin/users/groups'
          end

          def show_users_group( name )
            call :get, 'system/uadmin/users/groups/', name: name
          end

          ##########################################################################
          # Users > accounts > groups
          ##########################################################################

          def delete_users_account_groups( user_uid, group_dns )
            call :delete, 'system/uadmin/users/accounts/groups', user_uid: user_uid, group_dns: group_dns
          end

          def new_users_account_groups( user_uid )
            call :get, 'system/uadmin/users/accounts/groups/new', user_uid: user_uid
          end

          def create_users_account_groups( user_uid, group_dns )
            call :post, 'system/uadmin/users/accounts/groups', user_uid: user_uid, group_dns: group_dns
          end

          ##########################################################################
          # Users > accounts > email
          ##########################################################################

          def create_users_account_email( user_uid, email )
            call :post, 'system/uadmin/users/accounts/email', user_uid: user_uid, email: email
          end

          def edit_users_account_email( user_uid )
            call :get, 'system/uadmin/users/accounts/email/edit', user_uid: user_uid
          end

          def update_users_account_email( user_uid, email )
            call :put, 'system/uadmin/users/accounts/email', user_uid: user_uid, email: email
          end

          def delete_users_account_email( user_uid )
            call :delete, 'system/uadmin/users/accounts/email', user_uid: user_uid
          end

          ########################################################################
          # Users > accounts > email > distribution groups
          ########################################################################

          def new_users_account_email_distribution_group( user_uid )
            call :get, 'system/uadmin/users/accounts/email/distribution_groups/new', user_uid: user_uid
          end

          def create_users_account_email_distribution_group( user_uid, distribution_group )
            call :post, 'system/uadmin/users/accounts/email/distribution_groups/', user_uid: user_uid, distribution_group: distribution_group
          end

          # def delete_users_account_email_distribution_group( user_uid, address )
          #   byebug
          #   call :delete, 'system/uadmin/users/accounts/email/distribution_groups/', user_uid: user_uid, address: address
          # end

          ########################################################################
          # Users > accounts > email > aliases
          ########################################################################

          def create_users_email_alias( user_uid, email_alias )
            # byebug
            call :post, 'system/uadmin/users/accounts/email/aliases/', user_uid: user_uid, alias: email_alias
          end

          def delete_users_email_alias( user_uid, address )
            call :delete, 'system/uadmin/users/accounts/email/aliases/', user_uid: user_uid, address: address
          end

          ##########################################################################
          # Users > accounts > password
          ##########################################################################

          def update_users_account_password( user_uid, password )
            call :put, 'system/uadmin/users/accounts/password', user_uid: user_uid, password: { new: password }
          end

          ########################################################################
          # Email
          ########################################################################

          def show_email
            call :get, 'system/uadmin/email'
          end

          ########################################################################
          # Email > email addresses
          ########################################################################

          def index_email_email_addresses
            @system_api.get 'system/uadmin/email/email_addresses'
          end

          ########################################################################
          # Email > distribution groups
          ########################################################################

          def index_email_distribution_groups
            @system_api.get 'system/uadmin/email/distribution_groups'
          end

          def show_email_distribution_group( name )
            @system_api.get 'system/uadmin/email/distribution_groups/', name: name
          end

          def new_email_distribution_group
            @system_api.get 'system/uadmin/email/distribution_groups/new'
          end

          def create_email_distribution_group( distribution_group )
            @system_api.post 'system/uadmin/email/distribution_groups/', distribution_group: distribution_group
          end

          def edit_email_distribution_group( name )
            @system_api.get 'system/uadmin/email/distribution_groups/edit', name: name
          end

          def update_email_distribution_group( name, distribution_group )
            @system_api.put 'system/uadmin/email/distribution_groups/', name: name, distribution_group: distribution_group
          end

          def delete_email_distribution_group( name )
            @system_api.delete 'system/uadmin/email/distribution_groups/', name: name
          end

          ########################################################################
          # Email > distribution groups > email addresses
          ########################################################################

          def new_email_distribution_group_email_address( distribution_group_name )
            @system_api.get 'system/uadmin/email/distribution_groups/email_addresses/new', distribution_group_name: distribution_group_name
          end

          def create_email_distribution_group_email_address( distribution_group_name, email_address )
            @system_api.post 'system/uadmin/email/distribution_groups/email_addresses/', distribution_group_name: distribution_group_name, email_address: email_address
          end

          def delete_email_distribution_group_email_address( distribution_group_name, address )
            @system_api.delete 'system/uadmin/email/distribution_groups/email_addresses/', distribution_group_name: distribution_group_name, address: address
          end

          ##########################################################################
          # Apps and icons
          ##########################################################################

          def app_statuses
            call :get, 'containers/engines/status'
          end

          def icon_url_for(app_name)
            call :get, "containers/engine/#{app_name}/icon_url"
          end

          def blueprint_for(app_name)
            call :get, "containers/engine/#{app_name}/blueprint"
          end

          def websites_for(app_name)
            call :get, "containers/engine/#{app_name}/websites"
          end


        end

      end
    end
  end
end
