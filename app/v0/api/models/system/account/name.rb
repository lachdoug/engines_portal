class V0
  module Api
    module Models
      class System
        class Account
          class Name

            attr_reader :uid,
                        :full_name,
                        :first_name,
                        :last_name

            def initialize(system, uid, data)
              @system = system
              @uid = uid
              @full_name = data[:name]
              @first_name = data[:first_name]
              @last_name = data[:last_name]
            end

            def update( params )
              assign_attributes( params )
              save
            end

            def assign_attributes( params )
              @first_name = params[:first_name]
              @last_name = params[:last_name]
            end

            def save
              @system.api.update_users_account(
                uid,
                {
                  first_name: first_name,
                  last_name: last_name
                }
              )
            end

          end
        end
      end
    end
  end
end
