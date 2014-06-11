class ChangeLocalizableValueLength < ActiveRecord::Migration

  def change
    change_column :localizables, :value, :text
  end
end
