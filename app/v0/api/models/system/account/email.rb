class V0
  module Api
    module Models
      class System
        class Account
          class Email

            attr_reader :mailbox

            def initialize(system, uid, data)
              @system = system
              @uid = uid
              @data = data
            end

            def disabled?
              @data.empty?
            end

            def mailbox
              @mailbox ||= Mailbox.new( @system, @uid, @data[:mailbox] )
            end

            def aliases
              @aliases ||= Aliases.new( @system, @uid, @data[:aliases] )
            end

            def distribution_groups
              @distribution_groups ||= DistributionGroups.new( @system, @uid, @data )
            end

          end
        end
      end
    end
  end
end
