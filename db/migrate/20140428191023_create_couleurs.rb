class CreateCouleurs < ActiveRecord::Migration

  def change
    create_table :couleurs do |t|
      t.string :title
      t.string :coul_type
      t.string :value_coul
      t.integer :apps_id
      t.timestamps
    end
  end
end
