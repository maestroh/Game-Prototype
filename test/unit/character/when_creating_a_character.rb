require 'minitest/autorun'
require_relative '../mock'
require File.expand_path('../../../../lib/game/character.rb', __FILE__)
require File.expand_path('../../../../lib/game/ground.rb', __FILE__)

class WhenCreatingACharacter < MiniTest::Unit::TestCase
  
  def setup
    ground = Ground.new(1,1)
    
    @character = Character.new("character", ground)
  end
  
  def test_id_is_set
    assert_equal "character", @character.id
  end
  
end