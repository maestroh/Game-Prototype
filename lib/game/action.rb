require_relative "movement.rb"
require_relative "animation.rb"

def Action
  
  def initialize(actionID, objectID, animation, movement)
    @animation = animation
    @movement = movement
    @actionID = actionID
    @objectID = objectID
    
    @interrupts = []
  end
  
  def actionID
    @actionID
  end
  
  def objectID
    @objectID
  end
  
  def addInterrupt(interrupt)
    @interrupts << interrupt
  end
  
  def interrupt?(actionID)
    @interrupts.select {|i| i.actionID == actionID}.size > 0
  end
  
  def update
    @animation.draw
    @movement.update
  end
  
end