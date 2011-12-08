SIELHO::Application.routes.draw do
  get "estadisticas/index"

  get "buscar/index"

  match "/buscar" => "buscar#index"

  devise_for :users, :controllers => {:registrations => "devise/custom/registrations" }

  match 'parametrizacion/ocupacion/new' => "parametrizacion#newocupacion", :as => :nueva_ocupacion
  match 'parametrizacion/ocupacion/create' => "parametrizacion#create", :as => :ocupacions  
  
  match 'parametrizacion/departamento/new' => "parametrizacion#newdepartamento", :as => :nuevo_departamento
  match 'parametrizacion/departamento' => "parametrizacion#create", :as => :departamentos  
  
  match 'parametrizacion/estado/new' => "parametrizacion#newestado", :as => :nuevo_estado
  match 'parametrizacion/estado' => "parametrizacion#create", :as => :estados  


  match 'parametrizacion/institucion/new' => "parametrizacion#newinstitucion", :as => :nueva_institucion
  match 'parametrizacion/institucion' => "parametrizacion#create", :as => :institucions  

  match 'parametrizacion/tipodocumento/new' => "parametrizacion#newtipodocumento", :as => :nuevo_tipo_documento
  match 'parametrizacion/tipodocumento' => "parametrizacion#create", :as => :tipo_documentos  
  
  match 'parametrizacion/leyacuerdo/new' => "parametrizacion#newleyacuerdo", :as => :nuevo_leyacuerdo
  match 'parametrizacion/leyacuerdo' => "parametrizacion#create", :as => :ley_acuerdos  

  root :to => "static#index"
  match 'usuario/new' => "usuario#new" ,:as => :new_user 
  match 'usuario/create_oip' => "usuario#create", :as => :oips
  match 'usuario/create_enlace' => "usuario#create", :as => :enlaces
  match 'usuario/directorio' => "usuario#directorio", :as => :directorio
  match 'usuario/modificar_oip/:id' => "usuario#modificar_oip", :as => :edit_oip
  match 'usuario/:id/edit' => "usuario#editoip", :as => :oip
  match 'usuario/:id/editEnlace' => "usuario#editenlace", :as => :enlace
  match 'usuario/:id/activarOip' => "usuario#activar_oip",:as => :activar_oip
  match 'usuario/:id/activarEnlace' => "usuario#activar_enlace",:as => :activar_enlace
  match 'usuario/modificar_enlace/:id' => "usuario#modificar_enlace", :as => :edit_enlace

  match 'solicitud/natural/new' => "solicitud#solicitud_natural", :as => :solicitud_natural
  match 'solicitud/juridica/new' => "solicitud#solicitud_juridica", :as => :solicitud_juridica
  match 'solicitud/create' => "solicitud#create", :as => :solicituds
  match 'solicitud/:usuario_id/pendiente' => "solicitud#pendiente" , :as => :solicitudes_pendientes



  match 'usuario/:id/mensajes/index' => "mensajes#index", :as=>:inbox
  match 'usuario/:id/mensajes/:mensaje_id/leido' => "mensajes#leido", :as=>:leido
  match 'usuario/:id/mensajes/:mensaje_id/borrado' => "mensajes#borrado", :as=>:borrado
  match 'usuario/:id/mensajes/new' => "mensajes#new", :as => :mensaje_nuevo
  match 'usuario/:id/mensajes/:solicitud_id/new' => "mensajes#nuevo", :as => :contestar
  match 'usuario/:id/mensajes/create' =>  "mensajes#create" , :as => :mensajes
  match 'usuario/:id/mensajes/:mensaje_id/show' => "mensajes#show", :as =>:ver_mensaje
  match 'usuario/:id/mensajes/historial' => "mensajes#historial" , :as=>:historial
  match 'solicitud/:mensaje_id/clasificar' => "solicitud#clasificar", :as => :clasificar_solicitud
  match 'solicitud/:mensaje_id/justificar' => "solicitud#justificar", :as=> :justificacions
  match 'solicitud/:solicitud_id/expediente/:expediente_id/justificarEstado' => "solicitud#justificarCambio", :as=> :justificacionCambio 
  match 'solicitud/:solicitud_id/expediente/:expediente_id/asignar' => "solicitud#asignar", :as => :asignar
  match 'solicitud/:solicitud_id/expediente/:expediente_id/estado' => "solicitud#estado", :as => :cambiar_estado
  match 'solicitud/:solicitud_id/expediente/:expediente_id/show' => "solicitud#show", :as=> :ver_expediente
  match 'solicitud/:solicitud_id/expediente/:expediente_id/creat' => "solicitud#asignaEnlace", :as=> :asignacions
  match 'mensajes/:mensaje_id/download' => "mensajes#download", :as => :download 
 
  match 'plazo/new' => "usuario#newPlazo" ,:as => :new_plazo
  match 'plazo/create' => "usuario#createPlazo" ,:as => :create_plazo

  match 'solicitud/:solicitud_id/expediente/:expediente_id/reclasificar' => "solicitud#reclasificar", :as=> :reclasificar
  match 'solicitud/:solicitud_id/reasignar' => "solicitud#reasignar",:as => :reasignar 
  
  match 'asignacion/:asignacion_id/finalizar' => "solicitud#completar", :as=> :completar
  match 'asignacion/:asignacion_id/reasignar'=> "solicitud#reasignarSolicitud",:as=>:reasignarSolicitud
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
