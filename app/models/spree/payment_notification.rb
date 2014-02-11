module Spree
  class PaymentNotification < ActiveRecord::Base
    belongs_to :order
    serialize :params
    attr_protected
    
    def self.create_from_params(params)
      order = Order.where(id: params[:order_id]).first
      
      email = order.pag_seguro_payment_method.preferred_email
      token = order.pag_seguro_payment_method.preferred_token
      
      notification_code = params[:notificationCode]
      notification = ::PagSeguro::Notification.new(email, token, notification_code)

      self.create!(
        params: params,
        order_id: notification.id,
        status: notification.status,
        transaction_id: notification.transaction_id,
        notification_code: notification_code
      )
      
      notification
    end
  end
end