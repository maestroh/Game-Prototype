require 'minitest/autorun'
require 'gosu'
require File.expand_path('../../../lib/game/scene.rb', __FILE__)
require_relative 'Mock.rb'

class Scene_Test < MiniTest::Unit::TestCase
  
  def setup
    
  end
  
  def test_that_scene_returns_object_ids
    mock1 = MiniTest::Mock::new
    mock1.expect :id, 1
    mock1.expect :draw, nil
    mock2 = MiniTest::Mock::new
    mock2.expect :id, 2
    mock2.expect :draw, nil
    
    scene = Scene.new
    scene.add_object(mock1)
    scene.add_object(mock2)
    
    ids = scene.object_ids
    
    assert_includes ids, mock1.id 
    assert_includes ids, mock2.id
  end
  
  def test_that_scene_returns_object
    mock1 = MiniTest::Mock::new
    mock1.expect :id, 1
    mock1.expect :draw, nil
    mock2 = MiniTest::Mock::new
    mock2.expect :id, 2
    mock2.expect :draw, nil
    
    scene = Scene.new
    scene.add_object(mock1)
    scene.add_object(mock2)
    
    object1 = scene.get_object(mock1.id)
    
    assert_equal object1.id, mock1.id
  end
  
  def test_that_draw_calls_all_object_draw
    mock1 = MiniTest::Mock::new
    mock1.expect :id, 1
    mock1.expect :draw, nil
    mock2 = MiniTest::Mock::new
    mock2.expect :id, 2
    mock2.expect :draw, nil
    
    scene = Scene.new
    scene.add_object(mock1)
    scene.add_object(mock2)
    
    scene.draw
    
    mock1.verify_method(:draw)
    mock2.verify_method(:draw)
  end
  
  def test_that_update_calls_action_object_update
    mock1 = MiniTest::Mock::new
    mock1.expect :id, 1
    mock1.expect :draw, nil
    mock1.expect :update, nil, ["run"]
    mock1.expect :nil?, false
    
    mock2 = MiniTest::Mock::new
    mock2.expect :id, 2
    mock2.expect :draw, nil
    
    scene = Scene.new
    scene.add_object(mock1)
    scene.add_object(mock2)
    
    scene.update(1, "run")
    
    mock1.verify_method(:update)
  end
  
end