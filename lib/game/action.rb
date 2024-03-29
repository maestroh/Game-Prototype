require_relative "movement.rb"
require_relative "animation.rb"

class Action
  
  def initialize(objectID, actionID, animation, movement)
    @animation = animation
    @movement = movement
    @actionID = actionID
    @objectID = objectID
    @direction = Direction::Right
    @position = Vector2d.new(0,0)
    @interrupts = []
  end
  
  def actionID
    @actionID
  end
  
  def objectID
    @objectID
  end
  
  def position
    @movement.position
  end
  
  def addInterrupt(interrupt)
    @interrupts << interrupt
  end
  
  def interrupt?(actionID)
    @interrupts.select {|i| i.actionID == actionID}.size > 0
  end
  
  def done?
    @movement.done?
  end
  
  def update(direction, position)
    @direction = direction
    @position = position
    @movement.update(direction, position)
    @animation.update(@direction)
  end
  
  def draw
    @animation.draw
    @movement.draw
  end
  
end