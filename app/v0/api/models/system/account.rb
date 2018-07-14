class V0
  module Api
    module Models
      class System
        class Account

          attr_reader :uid

          def initialize(system, uid)
            @system = system
            @uid = uid
          end

          def data
            @data ||= @system.api.show_users_account uid
          end

          def name
            @name ||= Name.new @system, uid, data
          end

          def email
            @email ||= Email.new @system, uid, data[:email]
          end

          def setup_email
            @setup_email ||= SetupEmail.new @system, uid
          end

          def groups
            @groups ||= Groups.new @system, uid, data[:groups]
          end

          def remove_groups
            @remove_groups ||= RemoveGroups.new @system, uid, data[:groups]
          end

          def add_groups
            @add_groups ||= AddGroups.new @system, uid, data[:groups]
          end

          def is_administrator?
            groups.collection.any? { |group| group.dn == "cn=administrators,ou=Groups,dc=engines,dc=internal" }
          end

          def change_password( new_password )
            @system.api.update_users_account_password( uid, new_password )
          end

          def delete
            @system.api.delete_users_account( uid )
          end

        end
      end
    end
  end
end
