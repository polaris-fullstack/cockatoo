class MigrateOauthColumnToJson < ActiveRecord::Migration[8.0]
  def up
    change_column :connected_accounts, :auth, :jsonb, using: "auth::jsonb"
  end

  def down
    change_column :connected_accounts, :auth, :text, using: "auth::text"
  end
end
