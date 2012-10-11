require 'minitest/autorun'
require_relative '../mock'
require File.expand_path('../../../../lib/game/character.rb', __FILE__)
require File.expand_path('../../../../lib/game/ground.rb', __FILE__)
require File.expand_path('../../../../lib/game/vector2d.rb', __FILE__)

class WhenChangingCharacterState < MiniTest::Unit::TestCase
  
  def setup
    stand_sprite_sheet = MiniTest::Mock::new
    stand_move_vector = Vector2d.new(0,0)
    run_sprite_sheet = MiniTest::Mock::new
    run_move_vector = Vector2d.new(0,0)
    statemachine = MiniTest::Mock::new
    statemachine.expect :output_state, :running, [:standing, :run]
    
    ground = Ground.new(1,1)
    
    @character = Character.new(ground, stand_move_vector)
    @character.add_state(:standing, stand_sprite_sheet, stand_move_vector)
    @character.add_state(:running, run_sprite_sheet, run_move_vector)
    
    @character.add_statemachine(statemachine, :standing, :stand)
  end
  
  def test_state_was_changed
    assert_equal :standing, @character.in_state
    @character.change_state(:run)
    assert_equal :running, @character.in_state
  end
  
end