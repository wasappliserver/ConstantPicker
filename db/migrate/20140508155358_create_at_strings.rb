class CreateAtStrings < ActiveRecord::Migration
  def change
    create_table :at_strings do |t|
      t.string :title
      t.string :value
      t.belongs_to :app
      t.timestamps
    end
  end
end
