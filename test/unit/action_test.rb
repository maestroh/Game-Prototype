require 'minitest/autorun'
require File.expand_path('../../../lib/game/action.rb', __FILE__)
require File.expand_path('../../../lib/game/action_interrupt.rb', __FILE__)

class Action_Test < MiniTest::Unit::TestCase
  
  def setup
    @objectID = "object"
    @actionID = "action"
    
    animation = MiniTest::Mock::new
    animation.expect :draw, nil
    movement = MiniTest::Mock::new
    movement.expect :update, nil
    
    @action = Action.new(@objectID, @actionID, animation, movement)
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
  
  def test_should_update
    @action.update
  end
end