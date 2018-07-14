class CreateAccountShortcuts < ActiveRecord::Migration[5.2]

  def up
    create_table :account_shortcuts do |t|
      t.integer :shortcut_id
      t.string :account_uid
    end
    add_column :shortcuts, :all_accounts, :boolean
  end

  def down
    drop_table :account_shortcuts
    remove_column :shortcuts, :all_accounts
  end

end
