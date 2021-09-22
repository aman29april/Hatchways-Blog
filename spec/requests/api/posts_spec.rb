require 'rails_helper'

RSpec.describe 'Api::Posts', type: :request do
  describe 'GET /api/posts with invalid params' do
    before { get '/api/posts' }

    it 'should return status code 400' do
      expect(response).to have_http_status(400)
    end

    before { get '/api/posts', params: { tags: '' } }

    it 'should return status code 400 if tags is blank' do
      expect(response).to have_http_status(400)
    end

    context 'when sortBy is invalid' do
      before { get '/api/posts', params: { tags: 'science', sortBy: 'name' } }

      it 'should fail if sortBy is invalid' do
        expect(response).to have_http_status(400)

        expect(json['error']).to eq(I18n.t('error.posts.params.sort'))
      end
    end

    context 'when direction is invalid' do
      before { get '/api/posts', params: { tags: 'science', direction: 'up' } }
      it 'should fail if direction is invalid' do
        expect(response).to have_http_status(400)

        expect(json['error']).to eq(I18n.t('error.posts.params.direction'))
      end
    end
  end

  describe 'GET /api/posts with valid params' do
    context 'when tags is valid' do
      before { get '/api/posts', params: { tags: 'history' } }

      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end

      before { get '/api/posts', params: { tags: 'history,tech' } }

      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'should have valid posts' do
        expect(json['posts']).not_to be_empty
        values = values_from_json('id')
        expect(values).to eq(values.sort)
      end

      it 'should have required keys in response' do
        expect(json['posts'][0].keys).to contain_exactly('author', 'authorId', 'id',
                                                         'likes', 'popularity', 'reads', 'tags')
      end
    end

    context 'when sortBy is reads' do
      before { get '/api/posts', params: { tags: 'history,tech', sortBy: 'reads' } }

      it 'should fail if sortBy is invalid' do
        expect(json['posts']).not_to be_empty
        values = values_from_json('reads')
        expect(values).to eq(values.sort)
      end
    end

    context 'when sortBy is popularity' do
      before { get '/api/posts', params: { tags: 'history,tech', sortBy: 'popularity' } }

      it 'should fail if sortBy is invalid' do
        values = values_from_json('popularity')
        expect(values).to eq(values.sort)
      end
    end

    context 'when direction is valid' do
      before { get '/api/posts', params: { tags: 'history,tech', sortBy: 'popularity', direction: 'desc' } }

      it 'should fail if sortBy is invalid' do
        values = values_from_json('popularity')
        expect(values).to eq(values.sort.reverse)
      end
    end
  end
end
