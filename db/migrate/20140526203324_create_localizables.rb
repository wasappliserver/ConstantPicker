class CreateLocalizables < ActiveRecord::Migration
  def change
    create_table :localizables do |t|
      t.string :key_loc
      t.string :value
      t.string :lang
      t.integer :app_id
      t.boolean :missing,  default: false
 
      t.timestamps
    end
  end
end
