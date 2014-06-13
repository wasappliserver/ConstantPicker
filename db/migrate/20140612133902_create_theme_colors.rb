class CreateThemeColors < ActiveRecord::Migration
  def change
    create_table :theme_colors do |t|
      t.integer :app_id
      t.string :color

      t.timestamps
    end
  end
end
