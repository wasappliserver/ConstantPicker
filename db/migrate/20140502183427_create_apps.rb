class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.integer :apps_users_id
      t.timestamps
    end
  end
end
