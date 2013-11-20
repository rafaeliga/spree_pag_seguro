Spree::Address.class_eval do

    usar_como_cpf :cpf

    attr_accessor :require_phone, :require_cpf

    validates :cpf, :address_number, presence: true, if: :require_cpf?
    validates :phone_ddd, presence: true, if: :require_phone?

    def full_phone
      "#{phone_ddd} #{phone}".strip
    end

    def require_cpf?
      @require_cpf ||= false
    end

    def require_phone?
      @require_phone ||= false
    end

end
