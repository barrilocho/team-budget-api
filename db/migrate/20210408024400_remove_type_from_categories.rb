class RemoveTypeFromCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :type, :integer
  end
end
