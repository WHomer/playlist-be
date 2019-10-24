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

      @ps1 = create(:playlist_song, playlist: @p1, song: @s1)
      @ps1 = create(:playlist_song, playlist: @p1, song: @s2)
      @ps1 = create(:playlist_song, playlist: @p2, song: @s3)
      @ps1 = create(:playlist_song, playlist: @p2, song: @s4)

      sign_in @user
    end

    it 'user can retrieve all playlists' do
      get '/api/v1/playlists'

      playlists = JSON.parse(response.body, symbolize_names: true)[:data]
      first_playlist = playlists[0][:attributes]
      first_playlist_songs = first_playlist[:songs]
      first_playlist_song = first_playlist_songs[0]

      expect(response.status).to eq(200)

      expect(playlists.count).to eq(2)
      expect(first_playlist_songs.count).to eq(2)

      expect(first_playlist[:name]).to eq(@p1.name)
      expect(first_playlist_song[:source_track_id]).to eq(@s1.source_track_id)
      expect(first_playlist_song[:name]).to eq(@s1.name)
      expect(first_playlist_song[:album]).to eq(@s1.album)
      expect(first_playlist_song[:artist]).to eq(@s1.artist)
      expect(first_playlist_song[:genre]).to eq(@s1.genre)
      expect(first_playlist_song[:rating]).to eq(@s1.rating)
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

    it 'user receives a 404 error when retrieving all playlists' do
      get '/api/v1/playlists'

      error = JSON.parse(response.body, symbolize_names: true)[:errors][0]

      expect(response.status).to eq(404)

      expect(error[:status]).to eq(404)
      expect(error[:title]).to eq('Not Found')
    end
  end
end