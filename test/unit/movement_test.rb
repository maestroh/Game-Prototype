require 'minitest/autorun'
require 'gosu'
require File.expand_path('../../../lib/game/movement.rb', __FILE__)
require File.expand_path('../../../lib/game/vector2d.rb', __FILE__)

class Movement_Test < MiniTest::Unit::TestCase
  
  def test_get_position
    vector = Vector2d.new(1,1)
    movement = Movement.new(vector)
    
    current_position = movement.get_position
    
    assert_equal vector, current_position 
  end
  
  def test_update_location_with_vector
    vector = Vector2d.new(1,1)
    moveVector = Vector2d.new(1,1)
    movement = Movement.new(vector)
    
    movement.move!(moveVector)
    
    assert_equal Vector2d.new(2,2), movement.get_position
  end
  
  
end