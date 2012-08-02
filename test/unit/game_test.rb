require 'minitest/autorun'
require 'gosu'
require File.expand_path('../../../lib/game/key_bindings.rb', __FILE__)
require File.expand_path('../../../lib/game/key_binding.rb', __FILE__)
require File.expand_path('../../../lib/game/scene.rb', __FILE__)
require File.expand_path('../../../lib/game/game.rb', __FILE__)

class GameTest < MiniTest::Unit::TestCase
  def setup
    # mock objects
    @mock1 = MiniTest::Mock::new
    @mock1.expect :id, "buck"
    @mock1.expect :draw, nil
    @mock1.expect :perform_animation, true, ["buck_run"]
   
    
    # add mock objects to scene
    @scene = Scene.new
    @scene.add_object(@mock1)
    
    # create key bindings
    @key_bindings = KeyBindings.new
    @key_combo = [Gosu::KbRight]
    @run = KeyBinding.new @key_combo, "buck", "buck_run"
    @key_bindings.add_binding @run
    
    # add scene and key_bindings to game
    @game = Game.new(@scene, @key_bindings)
    
  end
  
  def test_game_update
       
    binding = @key_bindings.get_binding(@key_combo)
    refute_nil binding
    assert_equal binding.game_object_id, @run.game_object_id
    assert_equal binding.action_name, @run.action_name
    
    game_object = @scene.get_object(binding.game_object_id)
    assert_equal game_object.id, @mock1.id
    
    game_object.perform_animation(binding.action_name)
  end
  
  def test_that_game_calls_object_perform_animation
    @game.update(@key_combo)
    
    #@mock1.verify
  end
end