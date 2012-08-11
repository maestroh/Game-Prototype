class Ground
  def initialize(height, gravity)
    @height = height
    @gravity = gravity
  end
  
  def get_gravity
    @gravity
  end
  
  def above_ground?(y)
    y < @height
  end
  
  def below_ground?(y)
    y > @height
  end
  
  def on_ground?(y)
    y == @height
  end
 
  def get_height()
    @height
  end
end