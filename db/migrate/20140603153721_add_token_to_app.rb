class AddTokenToApp < ActiveRecord::Migration

  def change
    add_column :apps, :app_token, :string
  end

end
