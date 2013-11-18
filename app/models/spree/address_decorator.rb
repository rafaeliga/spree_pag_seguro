Spree::Address.class_eval do
    
    usar_como_cpf :cpf
    
    attr_accessible :cpf, :phone_ddd, :address_number
    
    validates :cpf, :address_number, :presence => true
    
    def full_phone
      "#{phone_ddd} #{phone}".strip
    end
    
end
