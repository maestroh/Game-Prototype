require 'minitest/autorun'
require File.expand_path('../../../../lib/game/statemachine.rb', __FILE__)

class When_Adding_First_Transition < MiniTest::Unit::TestCase
  
  def test_output_state_should_return
    sm = Statemachine.new
    sm.build do
      transition :standing, :jump, :jumping
    end
    
    output_state = sm.output_state :standing, :jump
    assert_equal  :jumping, output_state
  end
  
end