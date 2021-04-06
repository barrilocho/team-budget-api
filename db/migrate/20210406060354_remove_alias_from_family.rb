class RemoveAliasFromFamily < ActiveRecord::Migration[6.1]
  def change
    remove_column :families, :alias, :string
  end
end
