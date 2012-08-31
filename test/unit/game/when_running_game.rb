require 'minitest/autorun'
require_relative '../mock'
require 'gosu'
require File.expand_path('../../../../lib/game/game.rb', __FILE__)

class When_Running_Game < MiniTest::Unit::TestCase
  
  def setup
    @scene = MiniTest::Mock::new
    @scene.expect :id, 1
    @scene.expect :update, nil, ["object","run"]
    @scene.expect :draw, nil
    
    @key_binding = MiniTest::Mock::new
    @key_binding.expect :action_name, "run"
    @key_binding.expect :game_object_id, "object"
    @key_binding.expect :key_combo, [Gosu::KbRight]
    
    @key_bindings = MiniTest::Mock::new
    @key_bindings.expect :get_binding, @key_binding, [[Gosu::KbRight]]
    
    @game = Game.new(@scene, @key_bindings)
    @game.update([Gosu::KbRight])
    @game.draw
  end
  
  def test_key_bindings_get_binding_is_called
    @key_bindings.verify_method :get_binding
  end
  
  def test_scene_update_is_called
    @scene.verify_method :update
  end
  
  def test_scene_draw_is_called
    @scene.verify_method :draw
  end
  
end