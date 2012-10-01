# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20121001211520) do

  create_table "campos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campos_congresos", :id => false, :force => true do |t|
    t.integer  "congreso_id"
    t.integer  "campo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ciudades", :force => true do |t|
    t.string   "nombre"
    t.string   "siglas"
    t.integer  "factura_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "congresos", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "precio",                      :precision => 12, :scale => 2
    t.datetime "fecha_inicio"
    t.datetime "fecha_fin"
    t.string   "lugar"
    t.integer  "user_id"
    t.decimal  "precio_descuento",            :precision => 12, :scale => 2
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
    t.string   "constancias_bg_file_name"
    t.string   "constancias_bg_content_type"
    t.integer  "constancias_bg_file_size"
    t.datetime "constancias_bg_updated_at"
    t.boolean  "pago"
    t.datetime "limite_registro"
  end

  create_table "congresos_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "congreso_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estados", :force => true do |t|
    t.integer  "pais_id"
    t.string   "siglas",     :limit => 20
    t.string   "nombre",     :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "factura_id"
  end

  create_table "facturas", :force => true do |t|
    t.string   "nombre"
    t.integer  "cp"
    t.string   "rfc"
    t.string   "ciudad"
    t.string   "pais"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "calle"
    t.integer  "numero"
    t.integer  "ciudad_id"
    t.integer  "persona_id"
    t.integer  "estado_id"
  end

  create_table "grado_estudios", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nombre"
    t.integer  "congreso_id"
  end

  create_table "municipios", :force => true do |t|
    t.integer  "estado_id"
    t.string   "siglas",     :limit => 20
    t.string   "nombre",     :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paises", :force => true do |t|
    t.string   "siglas",     :limit => 20
    t.string   "nombre",     :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "factura_id"
  end

  create_table "persona_tipos", :force => true do |t|
    t.string  "nombre"
    t.string  "siglas"
    t.integer "congreso_id"
    t.decimal "precio",         :precision => 10, :scale => 2
    t.boolean "estatus_precio"
  end

  create_table "personas", :force => true do |t|
    t.string   "nombre",                        :limit => 100
    t.string   "apellido_paterno",              :limit => 100
    t.string   "apellido_materno",              :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "congreso_id"
    t.string   "email",                         :limit => 100
    t.integer  "pais_id"
    t.integer  "estado_id"
    t.integer  "municipio_id"
    t.string   "uid"
    t.string   "rfc"
    t.string   "curp"
    t.string   "calle"
    t.integer  "numero"
    t.integer  "cp"
    t.string   "institucion"
    t.string   "ciudad"
    t.boolean  "pago",                                         :default => false
    t.boolean  "descuento",                                    :default => false
    t.string   "informacion_pago"
    t.integer  "persona_tipo_id"
    t.string   "telefono"
    t.integer  "grado_estudio_id"
    t.string   "comprobante_pago_file_name"
    t.string   "comprobante_pago_content_type"
    t.integer  "comprobante_pago_file_size"
    t.datetime "comprobante_pago_updated_at"
    t.string   "nombre_gafete"
    t.string   "nombre_constancia"
    t.string   "codigo_postal"
    t.string   "anos_experiencia"
  end

  create_table "personas_talleres", :id => false, :force => true do |t|
    t.integer "persona_id"
    t.integer "taller_id"
  end

  create_table "talleres", :force => true do |t|
    t.string   "nombre",            :limit => 100
    t.text     "descripcion"
    t.decimal  "precio",                           :precision => 12, :scale => 2
    t.integer  "max_participantes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "concepto_id"
    t.integer  "congreso_id"
    t.datetime "fecha_inicio"
    t.datetime "fecha_fin"
    t.string   "lugar"
    t.string   "hora"
    t.string   "instructor"
    t.integer  "numero"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                     :null => false
    t.string   "email",                                     :null => false
    t.string   "persistence_token",                         :null => false
    t.string   "crypted_password",                          :null => false
    t.string   "password_salt",                             :null => false
    t.string   "single_access_token",                       :null => false
    t.string   "perishable_token",                          :null => false
    t.integer  "login_count",         :default => 0,        :null => false
    t.integer  "failed_login_count",  :default => 0,        :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "roles",               :default => "--- []"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
