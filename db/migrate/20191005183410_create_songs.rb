class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.integer :source_track_id
      t.string :name
      t.string :album
      t.string :artist

      t.timestamps
    end
  end
end
