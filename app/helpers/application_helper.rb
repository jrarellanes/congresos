module ApplicationHelper
  def paperclip_url(attachment)
    #FixMe: Esto debe buscar la url actual
    if Rails.env == "production"
      "http://congresos.uach.mx#{attachment.url}"
    elsif Rails.env == "development"
      "http://localhost:3000#{attachment.url}"
    end
  end

  def imagen?(nombre_archivo)
    nombre_separado = nombre_archivo.split "."
    extension = nombre_separado.last
    extension == "png" or extension == "jpg" or extension == "jpg" or extension == "gif"
  end
end
