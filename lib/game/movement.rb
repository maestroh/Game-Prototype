require_relative 'vector2d.rb'
require_relative 'gravity.rb'

class Movement
  
  def initialize(move_vector, ground)
    @move_vector = move_vector
    @position = Vector2d.new(0,0)
    @ground = ground
    @vx = 0
    @vy = 0
    @in_air = false
  end 
  
  def update_position!
    @position.x += @vx
    @vx = 0
    
    if @vy != 0 || @ground.above_ground?(@position.y)
      @position.y += @vy
      @vy -= @ground.get_gravity
    end
    
    if @ground.below_ground?(@position.y)
      @position.y = @ground.get_height
      @vy = 0
    end 
  end
  
  def done?
    @vx == 0 && @vy == 0
  end
  
  def position
    @position
  end
  
  def move!(direction, position)
    @position = position
    
    @vx = @move_vector.x * direction
    
    if @ground.on_ground?(@position.y) then
      @vy = @move_vector.y
    end
  end  
  
end
  