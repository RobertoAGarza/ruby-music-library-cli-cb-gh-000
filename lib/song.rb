class Song
  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    self.save 
    self
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

  def create 

end
