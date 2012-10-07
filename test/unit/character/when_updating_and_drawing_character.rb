require 'minitest/autorun'
require_relative '../mock'
require File.expand_path('../../../../lib/game/character.rb', __FILE__)
require File.expand_path('../../../../lib/game/ground.rb', __FILE__)
require File.expand_path('../../../../lib/game/vector2d.rb', __FILE__)

class WhenUpdatingAndDrawingCharacter < MiniTest::Unit::TestCase
  
  def setup
    stand_sprite_sheet = MiniTest::Mock::new
    stand_move_vector = Vector2d.new(0,0)
    run_sprite_sheet = MiniTest::Mock::new
    run_move_vector = Vector2d.new(0,0)
    
    ground = Ground.new(1,1)
    
    @character = Character.new("character", ground)
    @character.add_state("stand", stand_sprite_sheet, stand_move_vector)
    @character.add_state("run", run_sprite_sheet, run_move_vector)
    
    @character.change_state("stand")
    @character.change_state("run")
  end
  
  def test_state_was_changed
    assert_equal @character.in_state, "run"
  end
  
end