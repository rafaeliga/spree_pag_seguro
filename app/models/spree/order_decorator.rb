Spree::Order.class_eval do
  has_many :payment_notifications
  
  def payable_via_pag_seguro?
    !!Spree::PaymentMethod.where(type: "Spree::PaymentMethod::PagSeguroMethod").first
  end
  
  def pag_seguro_payment_method
    payment_method_id = self.payments.last.payment_method_id
    return Spree::PaymentMethod.where(type: "Spree::PaymentMethod::PagSeguroMethod", id: payment_method_id).first
  end
end
