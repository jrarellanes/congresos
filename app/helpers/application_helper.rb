module ApplicationHelper
  def pagos_url(persona,importe,concepto)
    url = "http://148.229.13.124/pagos/index/?CuantasVariables=1&Facultad=4300&IdGrupoConcepto=3&ManejaProrroga=0&Origen=CON"
    url + "&ApellidoPaterno=#{persona.apellido_paterno}&ApellidoMaterno=#{persona.apellido_materno}&Nombre=#{persona.nombre}"
    url + "&ImporteTotal=#{importe}&IdConcepto=#{concepto}&CorreoElectronico=#{persona.email}&IdCliente=#{persona.id}"
    url
  end
end
