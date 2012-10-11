require 'minitest/autorun'
require_relative '../mock'
require File.expand_path('../../../../lib/game/character.rb', __FILE__)
require File.expand_path('../../../../lib/game/ground.rb', __FILE__)
require File.expand_path('../../../../lib/game/vector2d.rb', __FILE__)

class WhenCreatingACharacter < MiniTest::Unit::TestCase
  
  def setup
    state = MiniTest::Mock::new
    ground = Ground.new(1,1)
    move_vector = Vector2d.new(0,0)
    
    @character = Character.new(ground, move_vector)
    @character.add_state(:standing, state, move_vector)
  end
  
  def test_state_was_added
    assert_includes @character.states, :standing
  end
  
end