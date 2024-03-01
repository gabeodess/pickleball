class AddDuprIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :dupr_id, :integer, limit: 8
    remove_column :users, :dupr_refresh_token, :string
  end
end
