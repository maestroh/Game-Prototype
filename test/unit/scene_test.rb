require 'minitest/autorun'
require 'gosu'
require File.expand_path('../../../lib/game/scene.rb', __FILE__)

class Scene_Test < MiniTest::Unit::TestCase
  
  def setup
    #mock objects
    @mock1 = MiniTest::Mock::new
    @mock1.expect :id, 1
    @mock1.expect :draw, nil
    @mock2 = MiniTest::Mock::new
    @mock2.expect :id, 2
    @mock2.expect :draw, nil
    
    #add mock objects to scene
    @scene = Scene.new
    @scene.add_object(@mock1)
    @scene.add_object(@mock2)
  end
  
  def test_that_scene_returns_object_ids
    ids = @scene.object_ids
    
    assert_includes ids, @mock1.id 
    assert_includes ids, @mock2.id
  end
  
  def test_that_scene_returns_object
    object1 = @scene.get_object(@mock1.id)
    
    assert_equal object1.id, @mock1.id
  end
  
end