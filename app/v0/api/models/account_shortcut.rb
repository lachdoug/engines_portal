class V0
  module Api
    module Models
      class AccountShortcut < ActiveRecord::Base

        # attr_accessor :shortcut_id, :account_uid

        belongs_to :shortcut #, dependent: :destroy



      end
    end
  end
end
