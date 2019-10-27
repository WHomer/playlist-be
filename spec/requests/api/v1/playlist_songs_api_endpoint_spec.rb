require 'rails_helper'

RSpec.describe 'Playlists API endpoint' do
  describe 'as an authenticated user' do
    before :each do
      @user = create(:user, email: 'email@test.com', password: 'test123')

      @s1 = create(:song)
      @s2 = create(:song)
      @s3 = create(:song)
      @s4 = create(:song)

      @p1 = create(:playlist, user: @user)
      @p2 = create(:playlist, user: @user)

      create(:playlist_song, playlist: @p1, song: @s1)
      create(:playlist_song, playlist: @p1, song: @s2)
      create(:playlist_song, playlist: @p2, song: @s3)
      create(:playlist_song, playlist: @p2, song: @s4)

      sign_in @user
    end

    it 'user can retrieve songs associated with a playlist' do
      get "/api/v1/playlists/#{@p1.id}/songs"

      playlist = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
      playlist_songs = playlist[:songs]
      first_playlist_song = playlist_songs[0]

      expect(response.status).to eq(200)

      expect(playlist_songs.count).to eq(2)

      expect(playlist[:name]).to eq(@p1.name)
      expect(first_playlist_song[:source_track_id]).to eq(@s1.source_track_id)
      expect(first_playlist_song[:name]).to eq(@s1.name)
      expect(first_playlist_song[:album]).to eq(@s1.album)
      expect(first_playlist_song[:artist]).to eq(@s1.artist)
      expect(first_playlist_song[:genre]).to eq(@s1.genre)
      expect(first_playlist_song[:rating]).to eq(@s1.rating)
    end

    it 'user receives a 404 error when no playlist is found to GET' do
      get '/api/v1/playlists/not_found/songs'

      error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

      expect(response.status).to eq(404)

      expect(error[:status]).to eq(404)
      expect(error[:title]).to eq('Not Found')
    end

    it 'user can add a song to a playlist' do
      post "/api/v1/playlists/#{@p1.id}/songs/#{@s3.id}"

      message = JSON.parse(response.body, symbolize_names: true)[:message]

      expect(response.status).to eq(201)

      expect(message).to eq("Successfully added #{@s3.name} to #{@p1.name}.")
    end

    it 'user recieves a 404 error if no playlist is found to POST' do
      post "/api/v1/playlists/not_found/songs/#{@s3.id}"

      error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

      expect(response.status).to eq(404)

      expect(error[:status]).to eq(404)
      expect(error[:title]).to eq('Not Found')
    end

    it 'user recieves a 404 error if no song is found to POST' do
      post "/api/v1/playlists/#{@p1.id}/songs/not_found"

      error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

      expect(response.status).to eq(404)

      expect(error[:status]).to eq(404)
      expect(error[:title]).to eq('Not Found')
    end
  end

  describe 'as an unauthenticated user' do
    before :each do
      @user = create(:user, email: 'email@test.com', password: 'test123')

      @s1 = create(:song)
      @s2 = create(:song)
      @s3 = create(:song)
      @s4 = create(:song)

      @p1 = create(:playlist, user: @user)
      @p2 = create(:playlist, user: @user)

      @ps1 = create(:playlist_song, playlist: @p1, song: @s1)
      @ps1 = create(:playlist_song, playlist: @p1, song: @s2)
      @ps1 = create(:playlist_song, playlist: @p2, song: @s3)
      @ps1 = create(:playlist_song, playlist: @p2, song: @s4)
    end

    it 'user receives a 404 error when retrieving songs associated with a playlist' do
      get "/api/v1/playlists/#{@p1.id}/songs"

      error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

      expect(response.status).to eq(404)

      expect(error[:status]).to eq(404)
      expect(error[:title]).to eq('Not Found')
    end

    it 'user receives a 404 error when adding a song to a playlist' do
      post "/api/v1/playlists/#{@p1.id}/songs/#{@s3.id}"

      error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

      expect(response.status).to eq(404)

      expect(error[:status]).to eq(404)
      expect(error[:title]).to eq('Not Found')
    end
  end
end