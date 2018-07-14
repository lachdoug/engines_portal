class V0
  module Api
    module Models
      class System
        class DistributionGroups

          def initialize(system)
            @system = system
          end

          def find( name )
            DistributionGroup.new( @system, name )
          end

          def index
            @system.api.index_email_distribution_groups
          end

          def create( distribution_group )
            @system.api.create_email_distribution_group distribution_group
          end

        end
      end
    end
  end
end
