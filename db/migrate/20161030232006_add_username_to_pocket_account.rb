class AddUsernameToPocketAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :pocket_accounts, :username, :string
  end
end
