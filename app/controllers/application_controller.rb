#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session, :current_user, :congreso_propio?, :taller_propio?, :pagos_url

  protected
  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end

  def authenticate
    unless current_user_session
      flash[:notice] = "Debe de iniciar sesión"
      redirect_to new_user_session_path
      return false
    end
  end

  def administrador?
    unless current_user_session and current_user.is_admin?
      flash[:notice] = "Necesita ser administrador"
      redirect_to root_path
    end
  end

  def congreso_propio?(congreso)
     current_user.congresos.include? congreso or current_user.is_admin?
  end

  def taller_propio?(taller)
    taller.congreso.users.include? current_user or current_user.is_admin?
  end

  def pagos_url(persona,importe,concepto)
    url = "#{Congresos::Application::config.servidor_pagos_uach}/pagos/index/?CuantasVariables=1&Facultad=1601&IdGrupoConcepto=3&ManejaProrroga=0&Origen=CON"
    url += "&ApellidoPaterno=#{persona.apellido_paterno}&ApellidoMaterno=#{persona.apellido_materno}&Nombre=#{persona.nombre}"
    url += "&ImporteTotal=#{importe}&IdConcepto=#{concepto}&CorreoElectronico=#{persona.email}&IdCliente=#{persona.id}"
    url
  end

  
end
