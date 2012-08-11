require_relative 'vector2d.rb'
require_relative 'gravity.rb'

class Movement
  
  def initialize(start_position, ground)
    @position = start_position
    @in_air = false
    @ground = ground
    @vx = 0
    @vy = 0
  end 
  
  def update_position!
    @position.x += @vx
    
    if @in_air == true
      if @ground.above_ground?(@position.y + @vy) || @ground.below_ground?(@position.y)
        @position.y += @vy
        @vy += @ground.get_gravity
      else
        @in_air = false
        @position.y = @ground.get_height
      end 
    end
  end
  
  def get_position
    @position
  end
  
  def move(vector)
    @vx = vector.x
    
    if vector.y > 0 && !@in_air then
      @in_air = true
      @vy = -vector.y
    end
  end  
  
end
  