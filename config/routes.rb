Rails.application.routes.draw do



  get 'acerca_de/index'

  resources :regresion

  resources :estadisticas

  resources :costos_civs
  resources :visados
  resources :honorario_minimos do
    collection do
      get 'buscar_por_costo_proyecto'
      get 'buscar_por_tipo_visado'
    end
  end

  root :to => "home#index"
  devise_for :usuarios, controllers: { registrations: "registrations"}

  resources :usuarios do

    collection do
      get '/', to: 'usuarios#index'
      get 'validar_usuario', to: 'usuarios#validar_usuario'
      get 'validar_mail', to: 'usuarios#validar_mail'
      get '/validar_ci', to: 'usuarios#validar_ci'
      get '/validar_civ', to: 'usuarios#validar_civ'
      get 'validar_mail_v2', to: 'usuarios#validar_mail_v2'
      get '/validar_ci_v2', to: 'usuarios#validar_ci_v2'
      get '/validar_civ_v2', to: 'usuarios#validar_civ_v2'
    end
  end

  

  resources :obras do
    resources :visados
    member do
      get 'readpdf'
      post 'aprobar_obra'
      post 'visar'
      post 'rechazar'
      post 'pagar'
      post 'oceprone'
    end
    collection do
      get 'validar_oceprone'
      get 'aranceles'
      get 'regresion_lineal'
      get 'estadisticas'
      get 'estadistica_aplicada'
    end 
  end

  get 'multifirma', controller: 'obras'
  get 'manual', controller: 'obras'
  get 'pasantes', controller: 'obras'
  get 'irene', controller: 'obras'
  get 'junta', controller: 'obras'
  get 'codigo', controller: 'obras'

  
  resources :area_exteriores do
    collection do
      get 'buscar_por_tipo_area'
    end 
  end 
  
  resources :costos do
    collection do
      get 'buscar_por_descripcion'
    end
  end


  get 'db_backup_restore/backup' 
  get 'db_backup_restore/restore' 






  resources :indice_costos_uso_cats


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
