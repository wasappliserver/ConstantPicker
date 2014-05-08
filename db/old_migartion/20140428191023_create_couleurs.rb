class CreateCouleurs < ActiveRecord::Migration

  def change
    create_table :couleurs do |t|
      t.string :title
      t.string :coul_type
      t.string :value_coul
      t.belongs_to :app
      t.timestamps
    end
  end
end
