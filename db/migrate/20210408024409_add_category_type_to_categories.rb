class AddCategoryTypeToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :category_type, :integer
  end
end
