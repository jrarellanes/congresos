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

ActiveRecord::Schema.define(:version => 20110712202003) do

  create_table "congresos", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "precio",      :precision => 12, :scale => 2
  end

  create_table "estados", :force => true do |t|
    t.integer  "pais_id"
    t.string   "siglas",     :limit => 20
    t.string   "nombre",     :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  create_table "personas", :force => true do |t|
    t.string   "nombre",           :limit => 100
    t.string   "apellido_paterno", :limit => 100
    t.string   "apellido_materno", :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "congreso_id"
    t.string   "email",            :limit => 100
    t.integer  "pais_id"
    t.integer  "estado_id"
    t.integer  "municipio_id"
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
  end

end
