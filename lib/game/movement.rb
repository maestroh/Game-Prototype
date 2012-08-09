require_relative 'vector2d.rb'

class Movement
  
  def initialize(start_position)
    @position = start_position
  end 
  
  def get_position
    @position
  end
  
  def move!(vector)
    @position += vector 
  end  
end
  