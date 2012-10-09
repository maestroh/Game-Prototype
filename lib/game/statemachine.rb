class Statemachine
  
  def initialize
    @states = Hash.new
  end
  
  def build(&block)
    self.instance_eval(&block)
  end
  
  def output_state(orig_state, event)
    events = @states[orig_state]
    if events.nil? then
      return nil
    end

    events[event]
  end
  
  private
  def transition(orig_state, event, output_state)
    # get event hash that matches with orig_state as key
    events = @states[orig_state]
    
    # if the hash is nil, create a new event hash
    if events.nil? then 
      events = Hash.new
      @states[orig_state] = events
    end
    
    # add an item to the event hash with output_state as the value
    events[event] = output_state
  end
  
  
end