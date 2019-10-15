class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error

  private

  def authenticate_user!
    if user_signed_in?
      super
    else
      unauthorized_error
    end
  end

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def record_not_found_error
    render json: {
      errors: [
        {
          status: 404,
          title: 'Not Found'
        }
      ]
    },
    status: :not_found
  end

  def unauthorized_error
    render json: {
      errors: [
        {
          status: 401,
          title: 'Unauthorized'
        }
      ]
    },
    status: :unauthorized
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: 400,
          title: 'Bad Request',
          detail: resource.errors
        }
      ]
    },
    status: :bad_request
  end
end
