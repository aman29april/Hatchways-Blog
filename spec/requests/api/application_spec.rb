require 'rails_helper'

RSpec.describe 'Api::Applications', type: :request do
  describe 'GET /ping' do
    before { get '/api/ping' }

    it 'should return status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'should have some results' do
      expect(json['success']).to be true
    end
  end
end
