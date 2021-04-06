class CreateMovements < ActiveRecord::Migration[6.1]
  def change
    create_table :movements do |t|
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.date :movement_date
      t. :amount

      t.timestamps
    end
  end
end
