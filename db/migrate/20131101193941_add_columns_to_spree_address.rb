class AddColumnsToSpreeAddress < SpreeExtension::Migration[4.2]
  def change
    add_column :spree_addresses, :cpf, :string
    add_column :spree_addresses, :address_number, :string
    add_column :spree_addresses, :phone_ddd, :string
  end
end
