class V0
  module Api
    module Models
      class Shortcut < ActiveRecord::Base

        default_scope { order('lower(label)') }

        def self.for( current_user )
          self.all
        end

        def icon_url
          if icon_present?
            "/shortcuts/#{id}/icon"
          else
            "/v0/no_icon.png"
          end
        end

        def icon_present?
          File.exist? "data/v0/icons/#{id}"
        end

        def icon_updated_at?
          icon_present? ? File.mtime("data/v0/icons/#{id}").to_i.to_s : ""
        end

        def icon_uploader
          IconUploader.new(self)
        end

        def delete_icon
          File.delete "data/v0/icons/#{id}"
        end

        def delete
          delete_icon if icon_present?
          super
        end

      end
    end
  end
end
