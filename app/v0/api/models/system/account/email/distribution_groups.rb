class V0
  module Api
    module Models
      class System
        class Account
          class Email
            class DistributionGroups

              def initialize(system, uid, data)
                @system = system
                @uid = uid
                @distribution_groups_data = data[:distribution_groups]
                @mailbox = data[:mailbox]
              end

              def empty?
                @distribution_groups_data.empty?
              end

              def collection
                @collection ||= @distribution_groups_data.map { |distribution_group| DistributionGroup.new( @system, @uid, distribution_group, @mailbox ) }
              end

              def each
                collection.each { |distribution_group| yield distribution_group }
              end

              def available
                @available_groups ||= @system.api.new_users_account_email_distribution_group( @uid )[:distribution_groups]
              end

              def add( distribution_group )
                @system.api.create_users_account_email_distribution_group( @uid, distribution_group )
              end

              def remove( distribution_group_name, email_address )
                @system.api.delete_email_distribution_group_email_address( distribution_group_name, email_address )
              end

            end
          end
        end
      end
    end
  end
end
