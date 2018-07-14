class V0
  module Api
    module Models
      class System
        class Account
          class Email
            class Mailbox

              def initialize(system, uid, address)
                @system = system
                @uid = uid
                @address = address
              end

              attr_reader :address

              def domain
                @domain ||= @address.split("@")[1]
              end

              def domains
                system_email[:domains]
              end

              def system_email
                @system_email ||= @system.email
              end

              def update( params )
                assign_attributes params
                save
              end

              def assign_attributes( params )
                @domain = params[:domain]
              end

              def save
                @system.api.update_users_account_email(
                  @uid,
                  { domain_name: domain }
                )
              end

            end
          end
        end
      end
    end
  end
end
