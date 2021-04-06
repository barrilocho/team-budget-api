class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :family, null: false, foreign_key: true
      t.integer :type

      t.timestamps
    end
  end
end
