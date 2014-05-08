class CreateAppsUsers < ActiveRecord::Migration
  def change
    create_table :apps_users do |t|
      t.belongs_to :app
      t.belongs_to :user
    end
  end
end
