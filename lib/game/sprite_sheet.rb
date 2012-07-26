require 'gosu'

class SpriteSheet
  def initialize(window, filename, tile_width, tile_height)
    @tiles = Gosu::Image::load_tiles(window, filename, tile_width, tile_height, false)
    @speed = 200
  end
  
  def set_speed(milliseconds)
    raise TypeError, "Integer argument expected" unless milliseconds.is_a? Integer
    @speed = milliseconds
  end
  
  def image
    @tiles[Gosu::milliseconds / @speed % @tiles.size];
  end
end