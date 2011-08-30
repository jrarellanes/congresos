#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin =   User.create(login: 'rgonzalez', password: '123pum', password_confirmation: '123pum',email: 'rgonzalez@uach.mx')
admin.add_role 'admin'

Estado.create([{:nombre => "Aguascalientes", :siglas => "AGS"},
              {:nombre => "Baja California",:siglas => "BC"},
              {:nombre => "Baja California Sur",:siglas => "BCS"},
              {:nombre => "Campeche",:siglas => "CAMP"},
              {:nombre => "Chiapas",:siglas => "CHIS"},
              {:nombre => "Chihuahua",:siglas => "CHIH"},
              {:nombre => "Coahuila",:siglas => "COAH"},
              {:nombre => "Colima",:siglas => "COL"},
              {:nombre => "Distrito Federal",:siglas => "DF"},
              {:nombre => "Durango",:siglas => "DGO"},
              {:nombre => "Guanajuato",:siglas => "GTO"},
              {:nombre => "Guerrero",:siglas => "GRO"},
              {:nombre => "Hidalgo",:siglas => "HGO"},
              {:nombre => "Jalisco",:siglas => "JAL"},
              {:nombre => "Estado de México",:siglas => "EDOMEX"},
              {:nombre => "Michoacán",:siglas => "MICH"},
              {:nombre => "Morelos",:siglas => "MOR"},
              {:nombre => "Nayarit",:siglas => "NAY"},
              {:nombre => "Nuevo León",:siglas => "NL"},
              {:nombre => "Oaxaca",:siglas => "OAX"},
              {:nombre => "Puebla",:siglas => "PUE"},
              {:nombre => "Querétaro",:siglas => "QRO"},
              {:nombre => "Quintana Roo",:siglas => "QR"},
              {:nombre => "San Luis Potosí",:siglas => "SLP"},
              {:nombre => "Sinaloa",:siglas => "SIN"},
              {:nombre => "Sonora",:siglas => "SON"},
              {:nombre => "Tabasco",:siglas => "TAB"},
              {:nombre => "Tamaulipas",:siglas => "TAM"},
              {:nombre => "Tlaxcala",:siglas => "TLX"},
              {:nombre => "Veracruz",:siglas => "VER"},
              {:nombre => "Yucatán",:siglas => "YUC"},
              {:nombre => "Zacatecas",:siglas => "ZAC"}])