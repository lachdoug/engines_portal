class V0
  module Api
    module Models
      class System
        class Groups

          def initialize(system)
            @system = system
          end

          def find( group_dn )
            @system.api.show_users_group group_dn
          end

          def index
            @system.api.index_users_groups
          end

        end
      end
    end
  end
end
