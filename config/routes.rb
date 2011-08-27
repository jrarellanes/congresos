Congresos::Application.routes.draw do
  get 'facturas/new/:id/participante' => "facturas#new", :as => :new_facturas

  resources :facturas, :except => :new

  get "inicio/home", :as => :home

  get "participantes/index"

  resources :talleres

  resources :congresos

  get 'participantes/:id/edit/:id_congreso' => "participantes#edit", :as => :edit_participante

  resources :personas

  get "congresos/:id/registro" => "congresos#registro", :as => :congreso_registro

  post "congresos/:id/registro" => "congresos#registrar", :as => :congreso_registrar

  get "congresos/:id/talleres"  => "congresos#talleres", :as => :congreso_talleres

  get "congresos/:id/participantes(.:format)" => "congresos#participantes", :as => :congreso_participantes

  get "logout" => "user_sessions#destroy", :as => :logout
  
  resource :user_session, :excep => :destroy

  resources :users

  get "congresos/:id/confirmar/:id_cliente/:id_transaccion/:origen" => "congresos#confirmar_pago", :as => :congreso_confirmar_pago
  #IdCliente
  #IdTransaccion
  #Origen=PAGOS



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'inicio#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
