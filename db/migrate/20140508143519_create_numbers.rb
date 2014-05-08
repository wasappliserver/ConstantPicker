class CreateNumbers < ActiveRecord::Migration
  def change
    create_table :numbers do |t|
      t.string :title
      t.string :value
      t.belongs_to :app
      t.timestamps
    end
  end
end
