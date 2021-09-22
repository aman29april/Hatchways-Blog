class ApplicationController < ActionController::API
  def render_json(object, status = :ok)
    render json: object, status: status
  end
end
