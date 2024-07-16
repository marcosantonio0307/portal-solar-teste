# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique, with: :record_invalid

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end

  def record_invalid(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def not_authorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def authenticate_internal_key
    not_authorized unless request.headers['Api-Internal-Key'] == ENV['API_INTERNAL_KEY']
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
