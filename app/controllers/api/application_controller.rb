class Api::ApplicationController < ApplicationController
  def ping
    render_json({ success: true })
  end
end
