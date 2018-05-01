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

          def call( method, route, params )
            @system_api.send( method, route, params.merge(
            { user_auth:
              { user_name: @session[:user_name],
                password: @session[:password] }  } ) )
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

          def delete_users_account_groups( user_uid, names )
            call :delete, 'system/uadmin/users/accounts/groups', user_uid: user_uid, names: names
          end

          def new_users_account_groups( user_uid )
            call :get, 'system/uadmin/users/accounts/groups/new', user_uid: user_uid
          end

          def create_users_account_groups( user_uid, groups )
            call :post, 'system/uadmin/users/accounts/groups', user_uid: user_uid, groups: groups
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

          ########################################################################
          # Users > accounts > email > aliases
          ########################################################################

          def create_users_email_alias( user_uid, _alias )
            call :post, 'system/uadmin/users/accounts/email/aliases/', user_uid: user_uid, alias: _alias
          end

          def delete_users_email_alias( user_uid, address )
            call :delete, 'system/uadmin/users/accounts/email/aliases/', user_uid: user_uid, address: address
          end

          ########################################################################
          # Users > accounts > email > distribution groups
          ########################################################################

          def create_users_email_distribution_group( user_uid, distribution_group )
            call :post, 'system/uadmin/users/accounts/email/distribution_groups/', user_uid: user_uid, distribution_group: distribution_group
          end

          def delete_users_email_distribution_group( user_uid, address )
            call :delete, 'system/uadmin/users/accounts/email/distribution_groups/', user_uid: user_uid, address: address
          end

          ##########################################################################
          # Users > accounts > password
          ##########################################################################

          def update_users_account_password( user_uid, password )
            call :put, 'system/uadmin/users/accounts/password', user_uid: user_uid, password: { new: password }
          end


        end

      end
    end
  end
end
