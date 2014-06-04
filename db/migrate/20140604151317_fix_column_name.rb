class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :apps, :token, :app_token
  end
end
