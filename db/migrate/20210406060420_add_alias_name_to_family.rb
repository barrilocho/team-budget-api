class AddAliasNameToFamily < ActiveRecord::Migration[6.1]
  def change
    add_column :families, :alias_name, :string
  end
end
