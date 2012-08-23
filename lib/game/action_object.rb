class ActionObject
  
  def initialize(position)
    @actions = Hash.new
    @position = position
  end
  
  def add_action(action)
    raise ArgumentError, "action already exists" unless @actions[action.actionID].nil?
    @actions[action.actionID] = action
    
    unless @active_action
      @active_action = action
    end
    
    unless @default_action
      @default_action = action
    end 
      
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
  
  def perform_action(actionID)
    raise ArgumentError, "action not found" unless !@actions[actionID].nil?
    if @active_action.interrupt?(actionID) 
      @active_action = get_action(actionID)
    end 
  end
  
  def update
    if !@active_action.done?
      @active_action.update
    else
      @active_action = @default_action
    end
  end
  
end