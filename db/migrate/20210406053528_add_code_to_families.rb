class AddCodeToFamilies < ActiveRecord::Migration[6.1]
  def change
    add_column :families, :code, :string
  end
end
