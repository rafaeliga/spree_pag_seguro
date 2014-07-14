Spree::Adjustment.class_eval do
  scope :positive_charge, lambda { where("amount > 0") }
end