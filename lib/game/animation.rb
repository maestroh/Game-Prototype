require_relative 'direction.rb'
require_relative 'z_order.rb'

class Animation
  def initialize(name, sprite_sheet)
    raise TypeError, "Argument expected to support 'image'" unless sprite_sheet.respond_to? :image
    
    @name = name
    @sprite_sheet = sprite_sheet
    @direction = Direction::Right
    @x = @y = 0
    @zorder = ZOrder::Background
    @color = Gosu::Color.new(0xffffffff)
  end
  
  def name
    @name
  end
  
  def warp(x,y)
    @x = x
    @y = y
  end
  
  def set_zorder(zorder)
    @zorder = zorder
  end
  
  def update(direction)
    @direction = direction
  end
    
  def draw()
    img = @sprite_sheet.image
    x_upperleft = @x - img.width / 2.0 * @direction
    y_upperleft = @y - img.height / 2.0
    img.draw(x_upperleft, y_upperleft , @zorder, @direction, 1, @color, :default)
  end
end

