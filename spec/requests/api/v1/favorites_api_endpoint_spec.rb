require 'rails_helper'

RSpec.describe 'Favorites API endpoint', type: :request do
  before :each do
    @user = create(:user, email: 'email@test.com', password: 'test123')

    @s1 = create(:song)
    @s2 = create(:song)
    @s3 = create(:song)
    @s4 = create(:song)

    @f1 = create(:user_song, user: @user, song: @s1)
    @f2 = create(:user_song, user: @user, song: @s2)

    sign_in @user
  end

  it 'user can retrieve all favorites' do
    get "/api/v1/favorites"

    favorites = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response.status).to eq(200)

    expect(favorites.length).to eq(2)

    song_1 = favorites[0][:attributes]
    expect(song_1[:name]).to eq(@s1.name)
    expect(song_1[:album]).to eq(@s1.album)
    expect(song_1[:artist]).to eq(@s1.artist)
    expect(song_1[:genre]).to eq(@s1.genre)
    expect(song_1[:rating]).to eq(@s1.rating)
    
    song_2 = favorites[1][:attributes]
    expect(song_2[:name]).to eq(@s2.name)
    expect(song_2[:album]).to eq(@s2.album)
    expect(song_2[:artist]).to eq(@s2.artist)
    expect(song_2[:genre]).to eq(@s2.genre)
    expect(song_2[:rating]).to eq(@s2.rating)
  end

  it 'user can retrieve a single favorite by ID' do
    get "/api/v1/favorites/#{@f1.id}"

    favorite = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(response.status).to eq(200)

    expect(favorite[:name]).to eq(@s1.name)
    expect(favorite[:album]).to eq(@s1.album)
    expect(favorite[:artist]).to eq(@s1.artist)
    expect(favorite[:genre]).to eq(@s1.genre)
    expect(favorite[:rating]).to eq(@s1.rating)
  end

  it 'user receives a 404 error when no favorite is found to GET' do
    get '/api/v1/favorites/not_found'

    error = JSON.parse(response.body, symbolize_names: true)[:error]

    expect(response.status).to eq(404)

    expect(error).to eq('Not found')
  end

  it 'user can create a new favorite' do
    params = {  source_track_id: @s3.source_track_id,
                name: @s3.name,
                artist: @s3.artist,
                album: @s3.album,
                rating: @s3.rating,
                user_id: @user.id
              }

    post '/api/v1/favorites', params: params

    favorite = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(response.status).to eq(201)

    expect(favorite[:name]).to eq(@s3.name)
    expect(favorite[:album]).to eq(@s3.album)
    expect(favorite[:artist]).to eq(@s3.artist)
    expect(favorite[:genre]).to eq(@s3.genre)
    expect(favorite[:rating]).to eq(@s3.rating)

    expect(@user.favorites.count).to eq(3)
  end

  it 'user can delete an existing favorite' do
    delete "/api/v1/favorites/#{@f2.id}"

    expect(response.status).to eq(204)

    expect(@user.favorites.count).to eq(1)
  end

  it 'user receives a 404 error when no favorite is found to DELETE' do
    delete "/api/v1/favorites/not_found"

    error = JSON.parse(response.body, symbolize_names: true)[:error]

    expect(response.status).to eq(404)

    expect(error).to eq('Not found')
  end
end
