class V0
  module Api
    module Models
      class System
        class Account
          class Email
            class DistributionGroups
              class DistributionGroup

                def initialize(system, uid, data, mailbox)
                  @system = system
                  @uid = uid
                  @data = data
                  @mailbox = mailbox
                end

                def name
                  @name ||= @data[:name]
                end

                def email_address
                  @email_address ||= @data[:email_address]
                end

                def label
                  name + ( email_address === @mailbox ? "" : " (alias #{email_address})" )
                end

                def distribution_group_name_and_email_address
                  name + ':' + email_address
                end

              end
            end
          end
        end
      end
    end
  end
end
