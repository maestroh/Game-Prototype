require 'minitest/autorun'
require 'gosu'
require File.expand_path('../../../lib/game/vector2d.rb', __FILE__)

class Vector2d_Test < MiniTest::Unit::TestCase
  
  def test_that_two_vectors_are_equal
    @firstVector = Vector2d.new(1,1)
    @secondVector = Vector2d.new(1,1)
    
    assert_equal @firstVector, @secondVector
  end
  
  def test_that_two_vectors_are_not_equal
    @firstVector = Vector2d.new(1,1)
    @secondVector = Vector2d.new(2,2)
    
    refute_equal @firstVector, @secondVector
  end
  
  def test_subtraction_of_vectors
    @firstVector = Vector2d.new(3,3)
    @secondVector = Vector2d.new(2,2)
    
    @resultVector = @firstVector - @secondVector
    
    assert_equal @resultVector, Vector2d.new(1,1)
  end
  
  def test_addition_of_vectors
    @firstVector = Vector2d.new(1,1)
    
    @resultVector = @firstVector + @firstVector
    
    assert_equal @resultVector, Vector2d.new(2,2)
  end
  
  def test_addition_assignment_combination_with_two_vectors
    @firstVector = Vector2d.new(1,1)
    @secondVector = Vector2d.new(1,1)
    
    @firstVector += @secondVector
    
    assert_equal @firstVector, Vector2d.new(2,2)
  end
end