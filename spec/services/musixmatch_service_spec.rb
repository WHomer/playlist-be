require 'rails_helper'

RSpec.describe MusixmatchService, type: :model do
  before :each do
    @musixmatch_service = MusixmatchService.new('Justin Bieber')
  end

  it 'exists' do
    expect(@musixmatch_service).to be_a MusixmatchService
  end

  describe 'instance methods' do
    it '.track_search' do
      response = @musixmatch_service.track_search
      track_list = response[:message][:body][:track_list]
      first_track = track_list[0][:track]

      expect(response).to be_a Hash
      expect(track_list.count).to eq(20)
      expect(first_track).to have_key(:album_name)
      expect(first_track).to have_key(:artist_name)
      expect(first_track).to have_key(:primary_genres)
      expect(first_track).to have_key(:track_name)
      expect(first_track).to have_key(:track_rating)
    end
  end
end
