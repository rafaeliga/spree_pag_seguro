class AddColumnsToSpreeAddress < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :cpf, :string
    add_column :spree_addresses, :address_number, :string
  end
end
