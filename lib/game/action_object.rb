class ActionObject
  
  def initialize(position)
    @actions = Hash.new
    @position = position
    @direction = nil
  end
  
  def add_action(action)
    raise ArgumentError, "action already exists" unless @actions[action.actionID].nil?
    @actions[action.actionID] = action
    
    @active_action = action unless @active_action
    @default_action = action unless @default_action
  end  
  
  def get_action(actionID)
    @actions[actionID] 
  end
  
  def set_default(actionID)
    raise ArgumentError, "action not found" unless !@actions[actionID].nil?
    @default_action = get_action(actionID)
  end
  
  def get_active_action
    @active_action
  end
  
  def update(actionID, direction)
    raise ArgumentError, "action not found" unless !@actions[actionID].nil?
    if @active_action.interrupt?(actionID) 
      @active_action = get_action(actionID)
    end 
    
    @direction = direction
    @active_action.update(@direction, @position)
  end
  
  def draw
    if @active_action.done?
      @active_action = @default_action
      @active_action.update(@direction, @position)
    end
    
    @active_action.draw
    @position = @active_action.position
  end
  
end