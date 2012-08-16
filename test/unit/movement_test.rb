require 'minitest/autorun'
require 'gosu'
require File.expand_path('../../../lib/game/movement.rb', __FILE__)
require File.expand_path('../../../lib/game/vector2d.rb', __FILE__)
require File.expand_path('../../../lib/game/ground.rb', __FILE__)
require File.expand_path('../../../lib/game/direction.rb', __FILE__)

class Movement_Test < MiniTest::Unit::TestCase
  
  def test_get_initial_position
    ground = Ground.new(1, 1)
    vector = Vector2d.new(0,0)
    movement = Movement.new(vector, ground)
    
    current_position = movement.get_position
    
    assert_equal vector, current_position 
  end
  
  def test_update_x_location_with_vector
    ground = Ground.new(1, 1)
    vector = Vector2d.new(10,0)
    positionVector = Vector2d.new(1,1)
    movement = Movement.new(vector, ground)
    
    movement.move(positionVector, Direction::Right)
    movement.update_position!
    
    assert_equal Vector2d.new(11,1), movement.get_position
  end
  
  def test_update_y_change_should_return_to_ground_height
    ground = Ground.new(1, 1)
    vector = Vector2d.new(0, 3)
    positionVector = Vector2d.new(1, 1)
    movement = Movement.new(vector, ground)

    movement.move(positionVector, Direction::Right)
    
    10.times do
      movement.update_position!
    end
    
    assert_equal Vector2d.new(1, ground.get_height), movement.get_position
  end
  
  def test_update_x_y_change_should_return_to_ground_height
    ground = Ground.new(1, 1)
    vector = Vector2d.new(3, 3)
    positionVector = Vector2d.new(1,1)
    movement = Movement.new(vector, ground)

    movement.move(positionVector, Direction::Right)

    10.times do
      movement.update_position!
    end
    
    assert_equal Vector2d.new(4, ground.get_height), movement.get_position
  end
  
end