class AddHighriseUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :highrise_url, :string
  end
end
