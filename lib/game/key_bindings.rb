class KeyBindings
  def initialize
    @bindings = []
  end
  
  def add_binding(binding)
    raise TypeError, "Argument expected to support 'key_combo'" unless binding.respond_to? :key_combo
    raise TypeError, "Argument expected to support 'game_object_id'" unless binding.respond_to? :game_object_id
    raise TypeError, "Argument expected to support 'action_name'" unless binding.respond_to? :action_name
    
    @bindings << binding
  end
  
  def get_binding(key_combo)
    raise TypeError, "key_combo argument expected to be an array" unless key_combo.kind_of?(Array)
    @bindings.select {|x| x.key_combo == key_combo}[0]
  end
end