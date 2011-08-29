#encoding:utf-8
#=RubyXlsxHelper
#Módulo para usar la libreria SimpleXlsxWriter y así crear archivos XLSX para Excel 2007 y 2010
#
#Este Módulo solo puede ser usada si el interprete de ruby es Ruby 1.9.2 o
#superior

module XlsxHelper

  require 'simple_xlsx'

  def create_xlsx_participantes(congreso)
    uuid = UUID.new
    
    path_temporal = File.join(Dir::tmpdir,"participantes.xlsx#{uuid.generate}")

    
    SimpleXlsx::Serializer.new(path_temporal) do |doc|
      doc.add_sheet("Participantes: #{congreso.nombre}") do |sheet|
        sheet.add_row(['Nombre','Apellido Paterno','Apellido Materno','Correo Electrónico','Talleres','Pago Total','Folio en Caja Única'])

        congreso.personas_confirmadas.each do |persona|

          talleres = persona.talleres
          pago = congreso.precio
          talleres.each do |taller|
            pago += taller.precio
          end

          sheet.add_row([persona.nombre,
                       persona.apellido_paterno,
                       persona.apellido_materno,
                       persona.email,
                       talleres.join(","),
                       "#{pago.to_s}0",
                       persona.informacion_pago
                       ])

        end
      end
    end
    archivo = File.new path_temporal
    data  = archivo.read()    
    archivo.close
    File.delete(path_temporal)
    data
  end

end