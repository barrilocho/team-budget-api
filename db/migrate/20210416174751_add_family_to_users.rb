class AddFamilyToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :family, null: false, foreign_key: true
    add_reference :users, :family, null: true, foreign_key: true
  end
end
