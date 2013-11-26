module Spree
  module PagSeguroHelper
    
    def pretty_time(time)
      [I18n.l(time.to_date, format: :long),
        time.strftime("%l:%M %p")].join(" ")
    end
    
  end
end