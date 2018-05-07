class CreateShortcuts < ActiveRecord::Migration[5.2]

  def up
    create_table :shortcuts do |t|
      t.string :label
      t.string :url
      t.string :shortcut_type
      t.string :engine_name
    end
  end

  def down
    drop_table :shortcuts
  end

end
