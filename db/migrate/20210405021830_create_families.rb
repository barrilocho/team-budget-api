class CreateFamilies < ActiveRecord::Migration[6.1]
  def change
    create_table :families do |t|
      t.string :alias_name
      t.integer :members
      t.integer :balance

      t.timestamps
    end
  end
end
