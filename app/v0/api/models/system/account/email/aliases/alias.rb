class V0
  module Api
    module Models
      class System
        class Account
          class Email
            class Aliases
              class Alias

                def initialize(system, uid, data)
                  @system = system
                  @uid = uid
                  @data = data
                end

                def email_address
                  @data
                end

              end
            end
          end
        end
      end
    end
  end
end
