require 'minitest/autorun'

class MiniTest::Mock
  def verify_method(name)
      expected = @expected_calls[name]
      msg1 = "expected #{name}, #{expected.inspect}"
      msg2 = "#{msg1}, got #{@actual_calls[name].inspect}"
  
      raise MockExpectationError, msg2 if
        @actual_calls.has_key? name and
        not @actual_calls[name].include?(expected)
  
      raise MockExpectationError, msg1 unless
        @actual_calls.has_key? name and @actual_calls[name].include?(expected)
      true
    end
end