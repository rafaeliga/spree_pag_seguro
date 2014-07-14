Spree::Core::Engine.routes.draw do
  patch "pag_seguro/notify", :to => "pag_seguro#notify"
  get "pag_seguro/callback", :to => "pag_seguro#callback"
  resources :payment_notifications, :only => [:create]
end