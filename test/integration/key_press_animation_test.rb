require "test/unit"
#Dir[File.dirname(__FILE__) + '../../../lib/*.rb'].each {|file| require file }
require File.expand_path('../../../lib/animation.rb', __FILE__)
require File.expand_path('../../../lib/scene.rb', __FILE__)
require File.expand_path('../../../lib/animate_object.rb', __FILE__)
require File.expand_path('../../../lib/sprite_sheet.rb', __FILE__)

puts $LOAD_PATH

class KeyPressAnimationTest < Test::Unit::TestCase
  
  def test_presskeys_multipletimes_animatedmultipletimes
    #assert_equal(3, MyMath.new().add(1, 2))
    
    @scene = Scene.new
    buck = AnimateObject.new("buck")
    buck.add_animation(Animation.new("buck_stance", SpriteSheet.new(self, "../media/guystance.png", 220, 371)))
    buck.add_animation(Animation.new("buck_run", SpriteSheet.new(self, "../media/guyrunning.png", 400, 370)))
    buck.perform_animation("buck_stance")
    @scene.add_object buck
    
    run = KeyBinding.new [Gosu::KbRight], "buck", "buck_run"
    @key_bindings.add_binding run
    
    binding = @key_bindings.get_binding(key_combo)
    assert_not_nil binding
    assert_equal binding.game_object_id, "buck"
    assert_equal binding.action_name, "buck_run"
    
    object = @scene.get_object(binding.game_object_id)
    assert_not_nil object
    
        
  end
  
  
end