require 'minitest/autorun'
require File.expand_path('../../../lib/game/action_object.rb', __FILE__)
require File.expand_path('../../../lib/game/vector2d.rb', __FILE__)
require File.expand_path('../../../lib/game/direction.rb', __FILE__)
require_relative 'Mock.rb'

class ActionObjectTest < MiniTest::Unit::TestCase
  
  def setup
    @actionObjectID = "object"
    @actionID1 = "stand"
    @actionID2 = "run"
    @actionID3 = "jump"
    @action1 = MiniTest::Mock::new
    @action1.expect :actionID, @actionID1
    @action1.expect :nil?, false
    @action2 = MiniTest::Mock::new
    @action2.expect :actionID, @actionID2
    @action2.expect :nil?, false
    @position = Vector2d.new(0,0)
  end
  
  def test_add_action
    action_object = ActionObject.new(@actionObjectID, @position)
    action_object.add_action(@action1)
    
    action = action_object.get_action(@actionID1)
    refute_nil action
  end
  
  def test_when_adding_duplicate_action_then_throw
    action_object = ActionObject.new(@actionObjectID, @position)
    assert_raises ArgumentError do
      action_object.add_action(@action1)
      action_object.add_action(@action1)
    end
  end
  
  def test_add_default_action
    action_object = ActionObject.new(@actionObjectID, @position)
    action_object.add_action(@action1)
    action_object.set_default(@actionID1)
    
    action = action_object.get_active_action
    refute_nil(action)
  end
  
  def test_first_action_added_set_to_default_action
    action_object = ActionObject.new(@actionObjectID, @position)
    action_object.add_action(@action1)
    active_action = action_object.get_active_action
    
    assert_equal @actionID1, active_action.actionID
  end
  
  def test_when_default_action_not_found_then_throw
    action_object = ActionObject.new(@actionObjectID, @position)
    assert_raises ArgumentError do
      action_object.set_default(@actionID1)
    end
  end
  
  def test_when_update_action_not_found_then_throw
    action_object = ActionObject.new(@actionObjectID, @position)
    action_object.add_action(@action1)
    action_object.add_action(@action2)
    
    assert_raises ArgumentError do
      action_object.update("someUnknownAction", Direction::Right)
    end
  end
  
  def test_update_action_interrupts_default_action
    defaultAction = mock(@actionID1, false, @actionID2, true)
    secondAction = mock(@actionID2, false, nil, false)
    
    action_object = ActionObject.new(@actionObjectID, @position)
    action_object.add_action(defaultAction)
    action_object.add_action(secondAction)
    
    action_object.update(defaultAction.actionID, Direction::Right)
    action_object.update(secondAction.actionID, Direction::Right)
    
    assert_equal secondAction.actionID, action_object.get_active_action.actionID
  end
  
  def test_update_does_not_interrupt_default_action
    defaultAction = mock(@actionID1, false, @actionID2, false)
    secondAction = mock(@actionID2, false, nil, false)
    
    action_object = ActionObject.new(@actionObjectID, @position)
    action_object.add_action(defaultAction)
    action_object.add_action(secondAction)
    
    action_object.update(defaultAction.actionID, Direction::Right)
    action_object.update(secondAction.actionID, Direction::Right)
    
    assert_equal defaultAction.actionID, action_object.get_active_action.actionID
  end
  
  def test_draw_performs_default_action_when_done
    defaultAction = mock(@actionID1, false, @actionID2, true)
    secondAction = mock(@actionID2, true, nil, false)
    
    action_object = ActionObject.new(@actionObjectID, @position)
    action_object.add_action(defaultAction)
    action_object.add_action(secondAction)
    
    action_object.update(secondAction.actionID, Direction::Right)
    action_object.draw
    
    assert_equal defaultAction.actionID, action_object.get_active_action.actionID
  end
  
  def test_perform_action_interrupts_action_and_returns_to_default
    defaultAction = mock(@actionID1, false, @actionID2, true)
    secondAction = mock(@actionID2, false, @actionID3, true)
    thirdAction = mock(@actionID3, false, nil, false)
    
    action_object = ActionObject.new(@actionObjectID, @position)
    action_object.add_action(defaultAction)
    action_object.add_action(secondAction)
    action_object.add_action(thirdAction)
    
    action_object.update(secondAction.actionID, Direction::Right)
    action_object.draw
    
    action_object.update(thirdAction.actionID, Direction::Right)
    action_object.draw
    
    assert_equal thirdAction.actionID, action_object.get_active_action.actionID
  end
  
  def test_update_action_when_action_object_updates
    action = MiniTest::Mock::new
    action.expect :update, nil, [Direction::Right, @position]
    action.expect :actionID, "run"
    action.expect :nil?, false
    action.expect :interrupt?, nil, ["run"]
    action_object = ActionObject.new(@actionObjectID, @position)
    action_object.add_action(action)
        
    action_object.update("run", Direction::Right)
    
    action.verify
    
  end
  
  def test_update_default_action_when_active_action_is_done
    default_action = MiniTest::Mock::new
    default_action.expect :update, nil, [Direction::Right, @position]
    default_action.expect :actionID, "stand"
    default_action.expect :interrupt?, true, ["run"]
    default_action.expect :draw, nil
    default_action.expect :position, Vector2d.new(2,2)
    
    active_action = MiniTest::Mock::new
    active_action.expect :actionID, "run"
    active_action.expect :done?, true
    active_action.expect :nil?, false
    active_action.expect :update, nil, [Direction::Right, @position]
    
    action_object = ActionObject.new(@actionObjectID, @position)
    action_object.add_action(default_action)
    action_object.add_action(active_action)
    action_object.update(active_action.actionID, Direction::Right)
    
    action_object.draw
    
    default_action.verify_method(:update)
    
  end
  
  def test_update_action_object_position_after_action_is_drawn
    default_action = MiniTest::Mock::new
    default_action.expect :update, nil, [Direction::Right, @position]
    default_action.expect :actionID, "stand"
    default_action.expect :interrupt?, false, ["stand"]
    default_action.expect :draw, nil
    default_action.expect :done?, false
    default_action.expect :position, Vector2d.new(2,2)
    
    action_object = ActionObject.new(@actionObjectID, @position)
    action_object.add_action(default_action)
    
    action_object.draw
    
    default_action.verify_method(:position)
  end
  
  def mock(id, done, interrupt_id, interrupt)
    action = MiniTest::Mock::new
    action.expect :done?, done
    action.expect :actionID, id
    action.expect :nil?, false
    action.expect :draw, nil
    action.expect :position, Vector2d.new(2,2)
    action.expect :update, nil, [Direction::Right, @position]
    if !interrupt.nil?
      action.expect :interrupt?, interrupt, [interrupt_id]
    end
    
    action
  end
end
  
  
