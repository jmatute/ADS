# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111130053104) do

  create_table "administradors", :force => true do |t|
    t.integer  "usuario_id"
    t.string   "pnombre"
    t.string   "snombre"
    t.string   "papellido"
    t.string   "sapellido"
    t.string   "email"
    t.string   "email2"
    t.string   "tlf"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asignacions", :force => true do |t|
    t.integer  "enlace_id"
    t.text     "descripcion"
    t.datetime "fechaInic"
    t.integer  "expediente_id"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clasificacions", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departamentos", :force => true do |t|
    t.integer  "institucion_id"
    t.text     "descripcion"
    t.string   "nombre"
    t.integer  "enlace_id"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documentos", :force => true do |t|
    t.string   "numero"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tipoDocumento_id"
  end

  create_table "enlaces", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "departamento_id"
    t.integer  "institucion_id"
    t.string   "pnombre"
    t.string   "snombre"
    t.string   "papellido"
    t.string   "sapellido"
    t.string   "email"
    t.string   "email2"
    t.string   "tlf"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estados", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "anterior_id"
  end

  create_table "expedientes", :force => true do |t|
    t.integer  "estado_id"
    t.integer  "solicitud_id"
    t.integer  "creador"
    t.datetime "fechaEntrega"
    t.datetime "fechaEmision"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "institucions", :force => true do |t|
    t.text     "descripcion"
    t.string   "nombre"
    t.string   "tipo_institucion"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "justificacions", :force => true do |t|
    t.text     "descripcion"
    t.datetime "fecha_cambio"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ley_acuerdos", :force => true do |t|
    t.string   "noLey"
    t.string   "noAcuerdo"
    t.date     "fechaGaceta"
    t.text     "descripcion"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
  end

  create_table "mensajes", :force => true do |t|
    t.integer  "emisor_id"
    t.integer  "destinatario_id"
    t.string   "titulo"
    t.text     "texto"
    t.binary   "documento_adjunto"
    t.datetime "fecha"
    t.integer  "expediente_id"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "leido"
    t.boolean  "borrado"
  end

  create_table "ocupacions", :force => true do |t|
    t.string   "nombre"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oips", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "institucion_id"
    t.string   "pnombre"
    t.string   "snombre"
    t.string   "papellido"
    t.string   "sapellido"
    t.string   "email"
    t.string   "email2"
    t.string   "tlf"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permisos", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permisos_rols", :id => false, :force => true do |t|
    t.integer "rol_id"
    t.integer "permiso_id"
  end

  create_table "rols", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "solicitantes", :force => true do |t|
    t.string   "nombre"
    t.integer  "documento_id"
    t.integer  "tipo_solicitante"
    t.text     "modo_contacto"
    t.integer  "ocupacion_id"
    t.string   "genero"
    t.string   "nivel_educativo"
    t.string   "telefono"
    t.string   "email"
    t.text     "direccion_postal"
    t.string   "fax"
    t.string   "poder"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "solicituds", :force => true do |t|
    t.integer  "solicitante_id"
    t.text     "descripcion"
    t.string   "lugar"
    t.integer  "institucion_id"
    t.datetime "fecha"
    t.integer  "clasificacion_id"
    t.integer  "expediente_id"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "numero"
  end

  create_table "tipo_documentos", :force => true do |t|
    t.string   "regla"
    t.string   "nombre"
    t.integer  "tipoPersona"
    t.datetime "fechaCrear"
    t.datetime "fechaMod"
    t.integer  "usuarioRes"
    t.integer  "usuarioMod"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.boolean  "activo"
    t.integer  "rol_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
