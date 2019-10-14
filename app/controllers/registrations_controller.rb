class RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: :create

  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.save

    render_resource(resource)
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
