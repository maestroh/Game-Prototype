class Ground
  def initialize(height)
    @height = height
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