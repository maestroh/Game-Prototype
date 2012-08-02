require 'minitest/autorun'
require 'gosu'
require File.expand_path('../../../lib/game/key_bindings.rb', __FILE__)
require File.expand_path('../../../lib/game/key_binding.rb', __FILE__)

class KeyBindingsTest < MiniTest::Unit::TestCase
  def setup
    @key_bindings = KeyBindings.new
    @key_combo = [Gosu::KbRight]
    @run = KeyBinding.new @key_combo, "buck", "buck_run"
    @key_bindings.add_binding @run
  end
  
  def test_that_keybindings_returns_binding
       
    binding = @key_bindings.get_binding([Gosu::KbRight])
    refute_nil binding
    assert_equal binding.game_object_id, "buck"
    assert_equal binding.action_name, "buck_run"
  end
end
