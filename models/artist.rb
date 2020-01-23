require("pry")
require('pg')
require_relative('../db/sql_runner.rb')


class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end





  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
    values = [@name]
    artists = SqlRunner.run(sql, values)
    @id = artists[0]["id"].to_i
  end


  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map{|person| Artist.new(person)}
  end



  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    albums = results.map{|album| Album.new(album)}
    return albums
  end

  def update()
  sql = "UPDATE artists SET name = $1 WHERE id = $2"
  values = [@name, @id]
  result = SqlRunner.run(sql, values)
end

def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
end


  def self.find()
    binding.pry
    sql = "Select * FROM artists WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return results = Artist.new(results.first)
  end


end
