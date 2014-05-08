class CreateAllTables < ActiveRecord::Migration

  def change

    create_table :apps do |t|
      t.string :name
      t.timestamps
    end

    create_table :couleurs do |t|
      t.string :title
      t.string :coul_type
      t.string :value_coul
      t.belongs_to :app
      t.timestamps
    end

    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.boolean :admin, default: false
      t.timestamps
    end

    create_table :apps_users do |t|
      t.belongs_to :app
      t.belongs_to :user
    end

  end
end
