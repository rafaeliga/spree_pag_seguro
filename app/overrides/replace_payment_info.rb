Deface::Override.new(
  virtual_path: "spree/shared/_order_details",
  name: "replace_payment_info",
  replace_contents: ".payment-info",
  partial: "spree/checkout/payment/order_details"
)