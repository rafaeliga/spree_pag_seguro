module Spree
  CheckoutController.class_eval do
    

    # Redireciona p/ o Pagseguro após completar o pedido.
    def completion_route
      payment = @order.payments.last
      
      if payment && (payment.payment_method.instance_of? Spree::PaymentMethod::PagSeguroMethod)
        ::PagSeguro::Payment.checkout_payment_url(payment.payment_method.code(payment))
      else
        order_path(@order)
      end
    end

  end
end