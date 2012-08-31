class Game
  def initialize(scene, key_bindings)
    
    @scene = scene
    @key_bindings = key_bindings
  end
  
  def update(key_combo)
    raise TypeError, "Array argument expected" unless key_combo.is_a? Array
    
    binding = @key_bindings.get_binding(key_combo)
    @scene.update(binding.game_object_id, binding.action_name)
  end
  
  def draw
    @scene.draw
  end
end