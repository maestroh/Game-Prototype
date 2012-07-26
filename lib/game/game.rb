class Game
  def initialize(scene, key_bindings)
    raise TypeError, "Scene expected to support 'get_object'" unless scene.respond_to? :get_object
    raise TypeError, "key_bindings expected to support 'get_binding'" unless key_bindings.respond_to? :get_binding
    
    @scene = scene
    @key_bindings = key_bindings
  end
  
  def update(key_combo)
    binding = @key_bindings.get_binding(key_combo)
    object = @scene.get_object(binding.game_object_id)
    object.perform_animation(binding.action_name)
  end
end