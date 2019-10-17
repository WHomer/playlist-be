require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:songs).through(:user_songs) }
  it { should have_many(:playlists) }
end
