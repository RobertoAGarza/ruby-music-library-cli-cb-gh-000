class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    @name = name
    newSong = Song.new(@name)
    newSong.save
    newSong
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    @genre.songs << self unless @genre.songs.include?(self)
  end

  def self.find_by_name(name)
    all.detect{ |song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(filename)
    fileArray = filename.split(" - ")
    artist = fileArray[0]
    song = fileArray[1]
    genre = fileArray[2].gsub(".mp3","")

    newArtist = Artist.find_or_create_by_name(artist)
    newGenre =Genre.find_or_create_by_name(genre)
    newSong = Song.new(song, newArtist, newGenre)
  end

  def self.create_from_filename(filename)
    newSong = self.new_from_filename(filename)
    newSong.save
  end

end
