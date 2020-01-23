require("pry")
require_relative("../models/album.rb")
require_relative("../models/artist.rb")


# Album.delete_all()
# Artist.delete_all()


artist1 = Artist.new({'name' => 'Korn'})
artist1.save()
album1 = Album.new({'song' => 'Alone I break',
              'artist_id' => artist1.id})
album1.save()


binding.pry
album1.artist()
nil
