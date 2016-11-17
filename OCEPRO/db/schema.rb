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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161030200909) do

  create_table "area_exteriores", force: :cascade do |t|
    t.string   "concepto",            limit: 255, null: false
    t.float    "desde",               limit: 24,  null: false
    t.float    "hasta",               limit: 24
    t.float    "porcentaje_concepto", limit: 24,  null: false
    t.integer  "created_by_id",       limit: 4,   null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "tipo_area",           limit: 255
  end

  add_index "area_exteriores", ["created_by_id"], name: "index_area_exteriores_on_created_by_id", using: :btree

  create_table "costos", force: :cascade do |t|
    t.string   "descripcion",   limit: 255, null: false
    t.float    "costos",        limit: 24,  null: false
    t.integer  "created_by_id", limit: 4,   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.datetime "valido_desde",              null: false
    t.datetime "valido_hasta"
  end

  add_index "costos", ["created_by_id"], name: "index_costos_on_created_by_id", using: :btree

  create_table "costos_civs", force: :cascade do |t|
    t.float    "civ",           limit: 24, null: false
    t.integer  "created_by_id", limit: 4,  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "costos_civs", ["created_by_id"], name: "index_costos_civs_on_created_by_id", using: :btree

  create_table "honorario_minimos", force: :cascade do |t|
    t.string   "concepto",      limit: 255, null: false
    t.float    "desde",         limit: 24,  null: false
    t.float    "hasta",         limit: 24
    t.float    "porcentaje",    limit: 24,  null: false
    t.integer  "created_by_id", limit: 4,   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "tipo_visado",   limit: 255
  end

  add_index "honorario_minimos", ["created_by_id"], name: "index_honorario_minimos_on_created_by_id", using: :btree

  create_table "honorarios_min_distancia_visados", force: :cascade do |t|
    t.integer "honorario_minimo_id", limit: 4
    t.integer "visado_id",           limit: 4
  end

  add_index "honorarios_min_distancia_visados", ["honorario_minimo_id"], name: "index_honorarios_min_distancia_visados_on_honorario_minimo_id", using: :btree
  add_index "honorarios_min_distancia_visados", ["visado_id"], name: "index_honorarios_min_distancia_visados_on_visado_id", using: :btree

  create_table "indice_costos_uso_cats", force: :cascade do |t|
    t.string   "vivienda_uso",       limit: 255, null: false
    t.float    "indice_complejidad", limit: 24,  null: false
    t.float    "indice_costo",       limit: 24,  null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "obras", force: :cascade do |t|
    t.string   "nombre",                     limit: 255,   null: false
    t.string   "propietario_parcela_nombre", limit: 255,   null: false
    t.string   "propietario_parcela_ci",     limit: 255,   null: false
    t.integer  "coordinador_proyecto_id",    limit: 4,     null: false
    t.string   "residente_obra_nombre",      limit: 255
    t.string   "residente_obra_civ",         limit: 255
    t.string   "direccion_obra",             limit: 255,   null: false
    t.string   "municipio_obra",             limit: 255,   null: false
    t.string   "uso_obra",                   limit: 255,   null: false
    t.string   "memoria_descriptiva",        limit: 255,   null: false
    t.integer  "n_oceprone",                 limit: 4
    t.float    "area_parcela",               limit: 24,    null: false
    t.float    "area_bruta_construccion",    limit: 24,    null: false
    t.float    "area_neta_construccion",     limit: 24,    null: false
    t.string   "status_obra",                limit: 255,   null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "tipo_obra",                  limit: 255
    t.text     "comentario",                 limit: 65535
    t.integer  "residente_ci",               limit: 4
    t.string   "tipo_ci_juridico",           limit: 255
    t.string   "tipo_ci_residente",          limit: 255
    t.string   "rif",                        limit: 255
  end

  add_index "obras", ["coordinador_proyecto_id"], name: "index_obras_on_coordinador_proyecto_id", using: :btree

  create_table "uso_construccions", force: :cascade do |t|
    t.string "descripcion_construccion", limit: 255, null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "nombres",                limit: 255, default: "", null: false
    t.string   "apellidos",              limit: 255, default: "", null: false
    t.string   "usuario",                limit: 255,              null: false
    t.string   "civ",                    limit: 255
    t.string   "cedula",                 limit: 255,              null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",                   limit: 4,   default: 3
    t.string   "tipo_ci_coordinador",    limit: 255
    t.datetime "deleted_at"
  end

  add_index "usuarios", ["cedula"], name: "index_usuarios_on_cedula", unique: true, using: :btree
  add_index "usuarios", ["civ"], name: "index_usuarios_on_civ", using: :btree
  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree
  add_index "usuarios", ["usuario"], name: "index_usuarios_on_usuario", unique: true, using: :btree

  create_table "visados", force: :cascade do |t|
    t.integer  "obra_id",                     limit: 4,                   null: false
    t.float    "area_bruta",                  limit: 24,                  null: false
    t.string   "tipo",                        limit: 255,                 null: false
    t.float    "complejidad",                 limit: 24,                  null: false
    t.float    "costo_construccion_estimado", limit: 24,                  null: false
    t.float    "costo_estimado_proyecto",     limit: 24
    t.float    "costo_completo",              limit: 24,                  null: false
    t.boolean  "es_repeticion",               limit: 1,   default: false, null: false
    t.integer  "cantidad_repeticiones",       limit: 4
    t.float    "costo_completo_repeticion",   limit: 24
    t.float    "arancel",                     limit: 24
    t.integer  "created_by_id",               limit: 4,                   null: false
    t.integer  "updated_by_id",               limit: 4,                   null: false
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.float    "costo_construccion",          limit: 24,                  null: false
    t.float    "porcentaje_tabla_datos",      limit: 24
  end

  add_index "visados", ["created_by_id"], name: "index_visados_on_created_by_id", using: :btree
  add_index "visados", ["obra_id"], name: "index_visados_on_obra_id", using: :btree
  add_index "visados", ["updated_by_id"], name: "index_visados_on_updated_by_id", using: :btree

end
