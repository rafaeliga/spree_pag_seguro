module Spree
  class PaymentNotification < ActiveRecord::Base
    belongs_to :order
    serialize :params
    attr_protected
    
    def self.create_from_params(params)
      
      notification_code = params[:notificationCode]
      notification = nil
      
      # Test all pagseguro payment_methods credencials
      Order.list_pag_seguro_payment_methods.each do |pm|
        email = pm.preferred_email
        token = pm.preferred_token
        
        begin
          notification = ::PagSeguro::Notification.new(email, token, notification_code)
        rescue
        end
        
        break unless notification.nil? 
      end
      
      
      
      

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