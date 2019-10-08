require 'rails_helper'

RSpec.describe 'Favorites API endpoint', type: :request do
  before :each do
    @user = create(:user)

    @s1 = create(:song)
    @s2 = create(:song)
    @s3 = create(:song)
    @s4 = create(:song)

    @f1 = create(:user_song, user: @user, song: @s1)
    @f2 = create(:user_song, user: @user, song: @s2)
    @f3 = create(:user_song, user: @user, song: @s3)
  end

  it 'user can retrieve a single favorite by ID' do
    get "/api/v1/favorites/#{@f1.id}"

    favorite = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(response).to be_successful

    expect(favorite[:name]).to eq(@s1.name)
    expect(favorite[:album]).to eq(@s1.album)
    expect(favorite[:artist]).to eq(@s1.artist)
    expect(favorite[:genre]).to eq(@s1.genre)
    expect(favorite[:rating]).to eq(@s1.rating)
  end

  it 'user receives a 404 error when no favorite is found' do
    get '/api/v1/favorites/9999'

    error = JSON.parse(response.body, symbolize_names: true)[:error]

    expect(response.status).to eq(404)

    expect(error).to eq('Not found')
  end
end
