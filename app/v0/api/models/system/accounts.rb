class V0
  module Api
    module Models
      class System
        class Accounts

          def initialize(system)
            @system = system
          end

          def find( uid )
            Account.new( @system, uid )
          end

          def index
            @system.api.index_users_accounts
          end

          def create( params )
            @system.api.create_users_account ( {
              uid: params[:uid],
              first_name: params[:first_name],
              last_name: params[:last_name],
              password: params[:password] } )
          end

        end
      end
    end
  end
end
