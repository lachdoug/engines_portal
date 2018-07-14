class V0
  module Api
    module Models
      class System
        class Account
          class Groups

            def initialize(system, uid, data)
              @system = system
              @uid = uid
              @data = data
            end

            def empty?
              @data.empty?
            end

            def collection
              @collection ||= @data.map { |group| Group.new( @system, @uid, group ) }
            end

            def each
              collection.each { |group| yield group }
            end

            def available_groups
              @available_groups ||= @system.api.new_users_account_groups( @uid )[:groups].map { |group| Group.new( @system, @uid, group ) }
            end

            def add( group_dns )
              @system.api.create_users_account_groups( @uid, group_dns )
            end

            def remove( group_dns )
              @system.api.delete_users_account_groups( @uid, group_dns )
            end

          end
        end
      end
    end
  end
end
