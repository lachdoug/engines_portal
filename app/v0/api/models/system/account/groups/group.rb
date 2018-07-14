class V0
  module Api
    module Models
      class System
        class Account
          class Groups
            class Group

              attr_reader :name

              def initialize(system, uid, data)
                @system = system
                @uid = uid
                @data = data
              end

              def name
                @name ||= @data[:name]
              end

              def dn
                @dn ||= @data[:dn]
              end

            end
          end
        end
      end
    end
  end
end
