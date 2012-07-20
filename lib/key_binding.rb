class KeyBinding
  
  def initialize(key_combo, game_object_id, action_name)
    raise TypeError, "key_combo argument expected to be an array" unless key_combo.kind_of?(Array)
         
    @key_combo = key_combo
    @game_object_id = game_object_id
    @action_name = action_name
  end
  
  def key_combo
    @key_combo
  end
  
  def game_object_id
    @game_object_id
  end
  
  def action_name
    @action_name
  end
  
end