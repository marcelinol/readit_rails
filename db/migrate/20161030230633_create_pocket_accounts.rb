class CreatePocketAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :pocket_accounts do |t|
      t.references :user, foreign_key: true, unique: true
      t.string :access_token

      t.timestamps
    end
  end
end
