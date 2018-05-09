class V0
  module Api
    module Models
      class Ldap
        class Account

          attr_reader :uid

          def initialize(system, uid)
            @system = system
            @uid = uid
          end

          def email
            ldap_account_details[:email]
          end

          def ldap_account_details
            @ldap_account_details ||= @system.ldap_users

        end
      end
    end
  end
end
