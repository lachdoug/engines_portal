class V0
  module Api
    module Models
      class Shortcut < ActiveRecord::Base

        attr_reader :websites, :default_icon_url

        has_many :account_shortcuts, -> { order(account_uid: :asc) }, dependent: :destroy

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

        def load_app_label_from( system )
          self.label = system.label_for engine_name
        end

        def load_app_websites_from( system )
          @websites = system.websites_for engine_name
        end

        def load_default_icon_url_from( system )
          @default_icon_url = system.icon_url_for engine_name
        end

        def load_defaults_from( system )
          load_app_label_from system
          load_app_websites_from system
          self.url = @websites[0]
          load_default_icon_url_from system
        end

        def available_accounts( system )
          system.accounts.index.reject { |account| account_shortcuts.find_by( { account_uid: account[:uid] } ) }
        end

      end
    end
  end
end
