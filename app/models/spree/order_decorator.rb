Spree::Order.class_eval do
  has_many :payment_notifications
  
  def payable_via_pag_seguro?
    self.list_pag_seguro_payment_methods.size > 0
  end
  

  def self.list_pag_seguro_payment_methods
    Spree::PaymentMethod.where(type: "Spree::PaymentMethod::PagSeguroMethod", active: true)
  end  
    
  def pag_seguro_payment_method
  	Spree::PaymentMethod.where(type: "Spree::PaymentMethod::PagSeguroMethod", active: true).first
  end
end