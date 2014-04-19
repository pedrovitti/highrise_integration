class AddHighriseIdToPeople < ActiveRecord::Migration
  def change
    add_column :people, :highrise_id, :string
  end
end
