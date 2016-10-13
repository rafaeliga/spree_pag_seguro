Spree::Address.class_eval do
    
    usar_como_cpf :cpf
    
    attr_accessible :cpf, :phone_ddd, :address_number, :address_district
    
    validates :cpf, :address_number, :address_district, :presence => true
    validates :phone_ddd, :presence => true, :if => :require_phone?
    
    def full_phone
      "#{phone_ddd} #{phone}".strip
    end
    
end
