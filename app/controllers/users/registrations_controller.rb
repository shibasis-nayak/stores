class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)

      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end