class V0
  module Api
    module Models
      class System
        class Account
          class Email
            class Aliases

              def initialize(system, uid, data)
                @system = system
                @uid = uid
                @data = data
              end

              def empty?
                @data.empty?
              end

              def collection
                @collection ||= @data.map { |email_alias| Alias.new( @system, @uid, email_alias ) }
              end

              def each
                # byebug
                collection.each { |email_alias| yield email_alias }
              end

              def system_email
                @system_email ||= @system.api.show_email
              end

              def add( email_alias )
                address = "#{email_alias[:local_part]}@#{email_alias[:domain]}"
                @system.api.create_users_email_alias( @uid, { address: address } )
              end

              def remove( email_address )
                @system.api.delete_users_email_alias( @uid, email_address )
              end

            end
          end
        end
      end
    end
  end
end
