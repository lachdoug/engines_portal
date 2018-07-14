class V0
  module Api
    module Models
      class System
        class Account
          class SetupEmail

            def initialize(system, uid)
              @system = system
              @uid = uid
            end

            def mailbox_domain
              @mailbox_domain ||= system_email[:default_domain]
            end

            def domains
              system_email[:domains]
            end

            def system_email
              @system_email ||= @system.api.show_email
            end

            def process( params )
              assign_attributes( params )
              save
            end

            def assign_attributes( params )
              @mailbox_domain = params[:mailbox_domain]
            end

            def save
              @system.api.create_users_account_email( @uid, { domain_name: mailbox_domain } )
            end

            def disable
              @system.api.delete_users_account_email( @uid )
            end

          end
        end
      end
    end
  end
end
