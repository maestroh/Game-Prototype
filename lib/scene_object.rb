require './z_order.rb'

class SceneObject

  def initialize(id, image)
    raise TypeError, "image argument expected to support 'draw'" unless image.respond_to? :draw
    
    @image = image
    @id = id
    @x = @y = 0
    @zorder = ZOrder::Background
  end  
  
  def set_zorder(zorder)
    @zorder = zorder
  end
  
  def id
    @id
  end
  
  def warp(x, y)
    @x, @y = x, y
  end
  
  def draw
    @image.draw(@x, @y, @zorder)
  end  
    
end