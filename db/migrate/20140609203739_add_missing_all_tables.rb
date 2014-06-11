class AddMissingAllTables < ActiveRecord::Migration

  def change
    add_column :couleurs, :edit_flag, :boolean
    add_column :at_strings, :edit_flag, :boolean
    add_column :numbers, :edit_flag, :boolean

  end
end
