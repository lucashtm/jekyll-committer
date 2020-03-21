class AddTokenToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :oauth_token, :string, max: 50
  end
end
