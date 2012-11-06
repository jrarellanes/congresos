#encoding:utf-8
#=RubyXlsxHelper
#Módulo para usar la libreria SimpleXlsxWriter y así crear archivos XLSX para Excel 2007 y 2010
#
#Este Módulo solo puede ser usada si el interprete de ruby es Ruby 1.9.2 o
#superior

module XlsxHelper

  require 'simple_xlsx'

  def create_xlsx_participantes(congreso)
    #uuid = UUID.new
    
    path_temporal = File.join(Dir::tmpdir,"participantes.xlsx#{congreso.id}#{Time.now}")

    
    SimpleXlsx::Serializer.new(path_temporal) do |doc|
      doc.add_sheet("Participantes: #{congreso.nombre}") do |sheet|

        campo_tipo_participante = true if congreso.campos.include?(Campo.find_by_nombre "Tipo Participante")
        campo_nombre = true if congreso.campos.include?(Campo.find_by_nombre "Nombre")
        campo_apellido_paterno = true if congreso.campos.include?(Campo.find_by_nombre "Apellido Paterno")
        campo_apellido_materno = true if congreso.campos.include?(Campo.find_by_nombre "Apellido Materno")
        campo_nombre_gafete = true if congreso.campos.include?(Campo.find_by_nombre "Nombre Gafete")
        campo_nombre_constancia = true if congreso.campos.include?(Campo.find_by_nombre "Nombre Constancia")
        campo_email = true if congreso.campos.include?(Campo.find_by_nombre "Email")
        campo_institucion = true if congreso.campos.include?(Campo.find_by_nombre "Institución")
        campo_puesto = true if congreso.campos.include?(Campo.find_by_nombre "Puesto")
        campo_tiempo_experiencia = true if congreso.campos.include?(Campo.find_by_nombre "Tiempo Experiencia")
        campo_grado_estudio = true if congreso.campos.include?(Campo.find_by_nombre "Grado Estudio")
        campo_ciudad = true if congreso.campos.include?(Campo.find_by_nombre "Ciudad")
        campo_codigo_postal = true if congreso.campos.include?(Campo.find_by_nombre "Código Postal")
        campo_estado = true if congreso.campos.include?(Campo.find_by_nombre "estado")
        campo_pais = true if congreso.campos.include?(Campo.find_by_nombre "País")
        campo_telefono = true  if congreso.campos.include?(Campo.find_by_nombre "Telefono")
        campo_carrera = true if congreso.campos.include?(Campo.find_by_nombre "Carrera")
        
        encabezado = []
        encabezado << 'Tipo de participante' if campo_tipo_participante
        encabezado << 'Nombre' if campo_nombre
        encabezado << 'Apellido Paterno' if campo_apellido_paterno
        encabezado << 'Apellido Materno' if campo_apellido_materno
        encabezado << 'Nombre Gafete' if campo_nombre_gafete
        encabezado << 'Nombre Constancia' if campo_nombre_constancia
        encabezado << 'Email' if campo_email
        encabezado << 'Institución' if campo_institucion
        encabezado << 'Puesto' if campo_puesto
        encabezado << 'Tiempo de experiencia' if campo_tiempo_experiencia
        encabezado << 'Grado de estudio' if campo_grado_estudio
        encabezado << 'Ciudad' if campo_ciudad
        encabezado << 'Código Postal' if campo_codigo_postal
        encabezado << 'Estado' if campo_estado
        encabezado << 'País' if campo_pais
        encabezado << 'Telefono' if campo_telefono
        encabezado << 'Carrera' if campo_carrera

        sheet.add_row(encabezado)

        congreso.personas_confirmadas.each do |row_person|

          talleres = row_person.talleres
          persona = []
          persona << row_person.persona_tipo.nombre unless row_person.persona_tipo.nil? if campo_tipo_participante
          persona << row_person.nombre  if campo_nombre
          persona << row_person.apellido_paterno if campo_apellido_paterno
          persona << row_person.apellido_materno if campo_apellido_materno
          persona << row_person.nombre_gafete if campo_nombre_gafete
          persona << row_person.nombre_constancia if campo_nombre_constancia
          persona << row_person.email if campo_email
          persona << row_person.institucion if campo_institucion
          persona << row_person.apellido_materno if campo_puesto
          persona << row_person.anos_experiencia if campo_tiempo_experiencia
          persona << row_person.grado_estudio.nombre unless row_person.grado_estudio.nil? if campo_grado_estudio
          persona << row_person.ciudad if campo_ciudad
          persona << row_person.cp if campo_codigo_postal
          persona << row_person.estado.nombre unless row_person.estado.nil? if campo_estado
          persona << row_person.pais.nombre unless row_person.pais.nil? if campo_pais
          persona << row_person.telefono if campo_telefono
          persona << row_person.carrera if campo_carrera
          persona << row_person.talleres.join(",") unless row_person.talleres.size == 0

          sheet.add_row(persona)

        end
        congreso.personas_sin_confirmar.each do |row_person|

          talleres = row_person.talleres

          persona = []
          persona << row_person.persona_tipo.nombre unless row_person.persona_tipo.nil? if campo_tipo_participante
          persona << row_person.nombre  if campo_nombre
          persona << row_person.apellido_paterno if campo_apellido_paterno
          persona << row_person.apellido_materno if campo_apellido_materno
          persona << row_person.nombre_gafete if campo_nombre_gafete
          persona << row_person.nombre_constancia if campo_nombre_constancia
          persona << row_person.email if campo_email
          persona << row_person.institucion if campo_institucion
          persona << row_person.apellido_materno if campo_puesto
          persona << row_person.anos_experiencia if campo_tiempo_experiencia
          persona << row_person.grado_estudio.nombre unless row_person.grado_estudio.nil? if campo_grado_estudio
          persona << row_person.ciudad if campo_ciudad
          persona << row_person.cp if campo_codigo_postal
          persona << row_person.estado.nombre unless row_person.estado.nil? if campo_estado
          persona << row_person.pais.nombre unless row_person.pais.nil? if campo_pais
          persona << row_person.telefono if campo_telefono
          persona << row_person.carrera if campo_carrera
          persona << row_person.talleres.join(",") unless row_person.talleres.size == 0
          sheet.add_row(persona)

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