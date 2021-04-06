class CreateFamilies < ActiveRecord::Migration[6.1]
  def change
    create_table :families do |t|
      t.string :code
      t.string :alias
      t.integer :members
      t.integer :balance

      t.timestamps
    end
  end
end
