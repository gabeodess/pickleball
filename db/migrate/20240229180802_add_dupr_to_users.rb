class AddDuprToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :doubles, :float, null: false, default: 0
    add_column :users, :singles, :float, null: false, default: 0
    add_column :users, :dupr_refresh_token, :string
  end
end
