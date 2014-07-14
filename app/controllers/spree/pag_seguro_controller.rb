module Spree
  class PagSeguroController < BaseController
    protect_from_forgery :except => [:notify]
    skip_before_filter :restriction_access
    
    def notify
      notify_params = params.permit(:notificationType, :notificationCode)
      notification = Spree::PaymentNotification.create_from_params(notify_params)
      
      if notification.approved?
        Order.transaction do
          @order = Spree::Order.find(notification.id)
          
          # 1. Assume that if payment notification comes, it's exactly for the amount
          # sent to pagseguro (safe assumption -- cart can't be edited while on pagseguro)
          # 2. Can't use Order#total, as it's intercepted by spree-multi-currency
          # which might lead to lots of false "credit owed" payment states
          # (when they should be "complete")
          @order.payments.last.complete
        end
      end
      
      if notification.disputed?
        Order.transaction do
          @order = Spree::Order.find(notification.id)
          @order.payments.last.started_processing
        end
      end

      if notification.returned? or notification.cancelled?
        Order.transaction do
          @order = Spree::Order.find(notification.id)
          @order.payments.last.started_processing
          @order.payments.last.failure
        end
      end
      
      render nothing: true, head: :ok
    end
    
    def callback
    end
    
  end
end