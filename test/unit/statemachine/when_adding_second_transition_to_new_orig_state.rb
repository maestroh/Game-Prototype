require 'minitest/autorun'
require File.expand_path('../../../../lib/game/statemachine.rb', __FILE__)

class When_Adding_Second_Transition_To_New_Orig_State < MiniTest::Unit::TestCase
  def setup
    @sm = Statemachine.new
    @sm.build do
      transition :standing, :run, :running
      transition :running, :jump, :jumpingforward
    end    
  end
  
   def test_first_output_state_should_return
    output_state = @sm.output_state :standing, :run
    assert_equal  :running, output_state
  end

  def test_second_output_state_should_return
    output_state = @sm.output_state :running, :jump
    assert_equal  :jumpingforward, output_state
  end
  
end