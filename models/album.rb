require('pg')
require_relative('../db/sql_runner.rb')
class Album
  attr_accessor :song
  attr_reader :id, :artist_id

  def initialize(options)
    @song = options['song']
    @id = options['id'].to_i() if options['id']
    @artist_id = options['artist_id'].to_i()
  end


  def save()
    sql = "INSERT INTO albums (song, artist_id) VALUES ($1, $2) RETURNING id"
    values = [@song, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map { |song| Album.new(song) }
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    artist_data = result.first
    artist = Artist.new(artist_data)
  end

  def update()
    sql = "UPDATE albums SET (song, id) = ($1, $2) WHERE artist_id = $3"
    values = [@song, @id, @artist_id]
    SqlRunner.run(sql, values)

  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def self.find(id)
    sql = "SELECT * FROM albums
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return results = Album.new(results.first)
  end

end
