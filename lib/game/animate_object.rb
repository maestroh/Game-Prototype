
class AnimateObject
   def initialize(id)
     @id = id
    @x = @y = 0

    @animations = []
    @current_animation = nil
  end  

  def id
    @id
  end
    
  def warp(x, y)
    @x, @y = x, y
  end
  
  def add_animation(animation)
    raise TypeError, "Argument expected to support 'draw'" unless animation.respond_to? :draw
    raise TypeError, "Argument expected to support 'warp'" unless animation.respond_to? :warp
    raise TypeError, "Argument expected to support 'name'" unless animation.respond_to? :name
    
    @animations << animation
  end
  
  def animation_names
    names = []
    
    @animations.each {|x| names << x.name}
    
    names
  end
  
  def perform_animation(name)
    @current_animation = @animations.select {|x| x.name == name}[0]
  end
 
  def draw(direction)
    @current_animation.warp(@x, @y)
    @current_animation.draw(direction)
  end  
      
end

