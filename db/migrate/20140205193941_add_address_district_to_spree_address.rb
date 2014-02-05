class AddAddressDistrictToSpreeAddress < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :address_district, :string
  end
end
