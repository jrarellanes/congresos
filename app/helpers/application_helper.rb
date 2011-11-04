module ApplicationHelper
  def paperclip_url(attachment)
    #FixMe: Esto debe buscar la url actual
    if Rails.env == "production"
      "http://congresos.uach.mx#{attachment.url}"
    elsif Rails.env == "development"
      "http://localhost:3000#{attachment.url}"
    end
  end
end
