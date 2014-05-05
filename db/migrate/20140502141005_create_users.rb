class CreateUsers < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.boolean :admin, default: false
      t.integer :apps_users_id

      t.timestamps
    end
  end
end