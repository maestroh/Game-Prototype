require 'gosu'

class SpriteSheet
  attr_reader :done
  
  def initialize(window, filename, tile_width, tile_height)
    @tiles = Gosu::Image::load_tiles(window, filename, tile_width, tile_height, false)
    @speed = 200
    
    @done = false
  end
  
  def set_speed(miliseconds)
    raise TypeError, "Integer argument expected" unless miliseconds.is_a? Integer
    @speed = miliseconds
  end
  
  def image
    image_number = Gosu::milliseconds / @speed % @tiles.size
    @done = (image_number == @tiles.size - 1) 
    
    @tiles[image_number]
  end
  
  def done?
    @done
  end
end