class AddNameToThemeColor < ActiveRecord::Migration
  def change
    add_column :theme_colors, :name, :string
  end
end
