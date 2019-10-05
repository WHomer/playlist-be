require 'rails_helper'

RSpec.describe Song, type: :model do
  it { should have_many(:users).through(:user_songs) }
end
