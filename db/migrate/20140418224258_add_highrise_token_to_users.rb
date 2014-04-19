class AddHighriseTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :highrise_token, :string
  end
end
