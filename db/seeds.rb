user_1 = User.create!(first_name: "William", last_name: "Homer", email: "whomeriii@gmail.com", password: 'william')
user_2 = User.create!(first_name: "Will", last_name: "Homer", email: "billyhomeriii@gmail.com", password: 'will12')
user_3 = User.create!(first_name: "Alex", last_name: "Mathieu", email: "alex.mathieu@gmail.com", password: 'alex12')

song_1 = Song.create!(name:"lose yourself", album:"8 mile", artist:"eminem", genre:"rap", rating:4)
song_2 = Song.create!(name:"whiskey glasses", album:"if i know me", artist:"morgan wallen", genre:"country", rating:3)
song_3 = Song.create!(name:"sandstorm", album:"before the storm", artist:"darude", genre:"techno", rating:2)
song_4 = Song.create!(name:"1st of tha month", album:"e. 1999 eternal", artist:"bone thugs-n-harmony", genre:"rap", rating:5)
song_5 = Song.create!(name:"this is how we do it", album:"this is how we do it", artist:"montell jordan", genre:"R&B", rating:2)
song_6 = Song.create!(name:"no woman no cry", album:"live!", artist:"bob marley", genre:"reggae", rating:1)
song_7 = Song.create!(name:"take the a train", album:"", artist:"duke ellington", genre:"jazz", rating:2)
song_8 = Song.create!(name:"friends in low places", album:"double live", artist:"garth brooks", genre:"country", rating:1)
song_9 = Song.create!(name:"bohemian rhapsody", album:"a night at the opera", artist:"queen", genre:"rock", rating:5)
song_10 = Song.create!(name:"hey jude", album:"hey jude", artist:"the beatles", genre:"rock", rating:5)
song_11 = Song.create!(name:"so what", album:"", artist:"miles davis", genre:"jazz", rating:5)

user_1.user_songs.create!(song_id: song_1.id)
user_1.user_songs.create!(song_id: song_2.id)
user_1.user_songs.create!(song_id: song_3.id)
user_1.user_songs.create!(song_id: song_4.id)
user_1.user_songs.create!(song_id: song_5.id)
user_1.user_songs.create!(song_id: song_6.id)
user_1.user_songs.create!(song_id: song_7.id)
user_1.user_songs.create!(song_id: song_8.id)
user_1.user_songs.create!(song_id: song_9.id)
user_1.user_songs.create!(song_id: song_10.id)
user_1.user_songs.create!(song_id: song_11.id)
user_2.user_songs.create!(song_id: song_1.id)
user_2.user_songs.create!(song_id: song_2.id)
user_2.user_songs.create!(song_id: song_3.id)
user_2.user_songs.create!(song_id: song_4.id)
user_2.user_songs.create!(song_id: song_5.id)
user_2.user_songs.create!(song_id: song_6.id)

playlist_1 = user_1.playlists.create!(name: 'killer jams')
playlist_2 = user_1.playlists.create!(name: 'killer jams 2')
playlist_3 = user_1.playlists.create!(name: 'killer jams the return')
playlist_4 = user_2.playlists.create!(name: 'my mix')

playlist_1.playlist_songs.create!(song_id: song_1.id)
playlist_1.playlist_songs.create!(song_id: song_2.id)
playlist_1.playlist_songs.create!(song_id: song_3.id)
playlist_1.playlist_songs.create!(song_id: song_4.id)
playlist_1.playlist_songs.create!(song_id: song_5.id)
playlist_2.playlist_songs.create!(song_id: song_5.id)
playlist_2.playlist_songs.create!(song_id: song_4.id)
playlist_2.playlist_songs.create!(song_id: song_3.id)
playlist_3.playlist_songs.create!(song_id: song_6.id)
playlist_4.playlist_songs.create!(song_id: song_7.id)
playlist_4.playlist_songs.create!(song_id: song_8.id)
playlist_4.playlist_songs.create!(song_id: song_9.id)
playlist_4.playlist_songs.create!(song_id: song_10.id)
playlist_4.playlist_songs.create!(song_id: song_11.id)
