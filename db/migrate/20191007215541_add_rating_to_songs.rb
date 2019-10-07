class AddRatingToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :rating, :integer
  end
end
