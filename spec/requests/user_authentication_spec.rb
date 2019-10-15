require 'rails_helper'

RSpec.describe 'User authentication', type: :request do
  before :each do
    user = create(:user, email: 'jahbs@hired.net', password: 'password')

    @params = {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  describe 'when params are correct' do
    before :each do
      post '/sign_in', params: @params
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns JWT token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end
  end
end
