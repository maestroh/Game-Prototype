require 'minitest/autorun'
require File.expand_path('../../../../lib/game/statemachine.rb', __FILE__)

class When_Event_Does_Not_Exist < MiniTest::Unit::TestCase
  
  def setup
    @sm = Statemachine.new
    @sm.build do
      transition :standing, :jump , :jumping
      transition :standing, :run, :running
    end    
  end
  
  def test_output_state_should_return_nil
    output_state = @sm.output_state :standing, :punch
    assert_nil output_state
  end
  
end