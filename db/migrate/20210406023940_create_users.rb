class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :auth_token
      t.references :family, null: false, foreign_key: true

      t.timestamps
    end
  end
end
