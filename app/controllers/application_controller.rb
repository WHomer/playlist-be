class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: 400,
          title: 'Bad Request',
          detail: resource.errors,
          code: 100
        }
      ]
    },
    status: :bad_request
  end

  private

  def record_not_found
    render json: { error: 'Not found' }, status: 404
  end
end
