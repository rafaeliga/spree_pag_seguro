Spree::Address.class_eval do

    usar_como_cpf :cpf

    attr_accessor :require_phone, :require_cpf

    validates :cpf, :address_number, presence: true, if: :require_cpf?

    def require_cpf?
      @require_cpf ||= false
    end

end
