require 'rails_helper'

RSpec.describe 'User registration', type: :request do
  describe 'when a user is unauthenticated' do
    before :each do
      @params = {
        user: {
          first_name: 'Billy',
          last_name: 'Homer',
          email: 'jahbs@hired.net',
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end

    it 'returns 400 when passwords do not match' do
      @params[:user][:password_confirmation] = 'invalidpassword'

      post '/sign_up', params: @params

      error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

      expect(error[:status]).to eq(400)
      expect(error[:detail][:password_confirmation]).to eq(["doesn't match Password"])
    end

    it 'returns 200' do
      post '/sign_up', params: @params

      expect(response.status).to eq(200)
    end

    it 'returns a new user' do
      post '/sign_up', params: @params

      user = JSON.parse(response.body, symbolize_names: true)

      expect(user[:first_name]).to eq('Billy')
      expect(user[:last_name]).to eq('Homer')
      expect(user[:email]).to eq('jahbs@hired.net')
    end
  end

  describe 'when a user already exists' do
    before :each do
      create(:user, email: 'jahbs@hired.net')
    end

    it 'returns a bad request with validation errors' do
      post '/sign_up', params: @params

      error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

      expect(error[:status]).to eq(400)
      expect(error[:title]).to eq('Bad Request')
    end
  end
end
