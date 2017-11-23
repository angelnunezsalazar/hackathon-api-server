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

ActiveRecord::Schema.define(version: 20171117081623) do

  create_table "clientes", force: :cascade do |t|
    t.string "numero_documento"
    t.string "codigo_unico"
    t.string "json"
  end

  create_table "cuentas", force: :cascade do |t|
    t.string "codigo_unico_cliente"
    t.string "numero_cuenta"
    t.decimal "saldo", precision: 10, scale: 3
    t.string "json"
  end

  create_table "movimientos", force: :cascade do |t|
    t.string "numero_tarjeta"
    t.string "numero_movimiento"
    t.string "json"
  end

  create_table "reclamos", force: :cascade do |t|
    t.string "codigo_unico_cliente"
    t.string "numero_reclamo"
    t.string "estado"
    t.string "json"
  end

  create_table "tarjetas", force: :cascade do |t|
    t.string "codigo_unico_cliente"
    t.string "numero_cuenta"
    t.string "numero_tarjeta"
    t.string "fecha_alta"
    t.string "fecha_vencimiento"
    t.decimal "saldo", precision: 10, scale: 3
    t.string "json"
  end

end
