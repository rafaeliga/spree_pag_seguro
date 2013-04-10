module Spree
  class PagSeguroPayment < ActiveRecord::Base
    attr_accessor :order_id
    belongs_to :payment
    
    def process!(payment)
      order = payment.order
      
      redirect_url = "#{Spree::Config[:site_url]}/orders/#{order.number}"

      pag_seguro_payment = ::PagSeguro::Payment.new(
        Order.pag_seguro_payment_method.preferred_email,
        Order.pag_seguro_payment_method.preferred_token,
        redirect_url: redirect_url,
        extra_amount: format("%.2f", payment.order.adjustments.credit.sum(:amount)),
        id: order.id)

      pag_seguro_payment.items = order_items(order) + order_charges(order)
      
      pag_seguro_payment.sender = ::PagSeguro::Sender.new(
                                    name: order.name, 
                                    email: order.email, 
                                    phone_number: order.ship_address.phone)
                                    
      pag_seguro_payment.shipping = ::PagSeguro::Shipping.new(
                                    type: ::PagSeguro::Shipping::UNIDENTIFIED, 
                                    state: order.ship_address.state.abbr, 
                                    city: order.ship_address.city, 
                                    postal_code: order.ship_address.zipcode, 
                                    street: order.ship_address.address1, 
                                    complement: order.ship_address.address2)
                                    
      self.code = pag_seguro_payment.code
      self.date = pag_seguro_payment.date
      self.save
    end
    
    def order_items(order)
      order.line_items.map do |item|
        pag_seguro_item = ::PagSeguro::Item.new
        pag_seguro_item.id = item.id
        pag_seguro_item.description = item.product.name
        pag_seguro_item.amount = format("%.2f", item.price.round(2))
        pag_seguro_item.quantity = item.quantity
        pag_seguro_item.weight = (item.product.weight * 1000).to_i if item.product.weight.present?
        pag_seguro_item.shipping_cost = "0.00"
        pag_seguro_item
      end
    end
      
    def order_charges(order)
      order.adjustments.positive_charge.map do |item|
        pag_seguro_item = ::PagSeguro::Item.new
        pag_seguro_item.id = item.id
        pag_seguro_item.description = item.label
        pag_seguro_item.amount = format("%.2f", item.amount.round(2))
        pag_seguro_item.quantity = 1
        pag_seguro_item.weight = 0
        pag_seguro_item.shipping_cost = "0.00"
        pag_seguro_item
      end
    end
    
  end
end
