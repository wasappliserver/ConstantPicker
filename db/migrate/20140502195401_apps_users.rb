class AppsUsers < ActiveRecord::Migration

  def change
    create_table :apps_users do |t|
      t.integer :apps_id
      t.integer :users_id
      t.timestamps
    end
  end
end
