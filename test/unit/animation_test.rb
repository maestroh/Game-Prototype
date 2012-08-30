require 'gosu'
require 'minitest/autorun'
require File.expand_path('../../../lib/game/animation.rb', __FILE__)

class Animation_Test < MiniTest::Unit::TestCase
  
  def setup
    
    @name = "run"
    @image = MiniTest::Mock::new
    @image.expect :draw, nil, [-0.5, -0.5, ZOrder::Background, Direction::Right, 1, Gosu::Color.new(0xffffffff), :default ] 
    @image.expect :width, 1
    @image.expect :height, 1
    sprite_sheet = MiniTest::Mock::new
    sprite_sheet.expect :image, @image
    @animation = Animation.new(@name, sprite_sheet)
    
  end
  
  def test_name_is_returned
    assert_equal @name, @animation.name
  end
  
  def test_image_draw_was_called
    @animation.update(Direction::Right)
    
    @animation.draw()
    
    @image.verify 
  end
  
end