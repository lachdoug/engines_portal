class V0
  module Api
    module Models
      class System
        class DistributionGroup

          attr_reader :name

          def initialize(system, name)
            @system = system
            @name = name
          end

          def data
            @data ||= @system.api.show_email_distribution_group name
          end

          def local_part
            @local_part ||= name.split('@')[0]
          end

          def domain
            @domain ||= name.split('@')[1]
          end

          def description
            data[:description]
          end

          def email_addresses
            data[:email_addresses]
          end

          def add( email_address )
            @system.api.create_email_distribution_group_email_address name, email_address
          end

          def remove( email_address )
            @system.api.delete_email_distribution_group_email_address name, email_address
          end

          def delete
            @system.api.delete_email_distribution_group name
          end

          def available_email_addresses
            @available_email_addresses ||= @system.api.new_email_distribution_group_email_address(name)[:email_addresses]
          end

          def update( distribution_group )
            @system.api.update_email_distribution_group( name, distribution_group )
          end

        end
      end
    end
  end
end
