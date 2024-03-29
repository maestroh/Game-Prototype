require 'minitest/autorun'
require File.expand_path('../../../lib/game/action.rb', __FILE__)
require File.expand_path('../../../lib/game/action_interrupt.rb', __FILE__)
require File.expand_path('../../../lib/game/vector2d.rb', __FILE__)

class Action_Test < MiniTest::Unit::TestCase
  
  def setup
    @objectID = "object"
    @actionID = "action"
    @position = Vector2d.new(1,1)
    
    @animation = MiniTest::Mock::new
    @animation.expect :draw, nil
    @animation.expect :update, nil, [Direction::Right]
    @movement = MiniTest::Mock::new
    @movement.expect :update, nil, [Direction::Right, @position]
    @movement.expect :draw, nil
    @movement.expect :done?, true
    @movement.expect :position, @position
    
    
    @action = Action.new(@objectID, @actionID, @animation, @movement)
  end
    
  def test_should_contain_objectID
    assert_equal @action.objectID, @objectID
  end  
  
  def test_should_contain_actionID
    assert_equal @action.actionID, @actionID
  end 
  
  def test_should_add_and_find_interrupt
    interrupt = ActionInterrupt.new("newaction")
    
    @action.addInterrupt(interrupt)
    
    assert_equal @action.interrupt?("newaction"), true
  end 
  
  def test_should_update_and_draw
    @action.update(Direction::Right, @position)
    @action.draw
    @action.done?
    @action.position

    @movement.verify
    @animation.verify
  end
  
  def test_position_should_equal_movement_position
    assert_equal @position, @action.position
  end
  
  def test_done_should_return_true_after_update
    @action.update(Direction::Right, @position)
    
    10.times do
      @action.draw
    end
    assert_equal true, @action.done?
  end
end