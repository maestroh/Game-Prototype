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
    
    #@bindings.each do |y|
    #  puts y.key_combo.class
    #  puts key_combo.class
    #  puts y.key_combo
    #  puts key_combo
    #  puts y.key_combo == key_combo
    #  puts y.key_combo.eql?(key_combo)
    #  puts y.key_combo.equal?(key_combo) 
    #  if y.key_combo == key_combo
    #    puts "hello"
    #    binding1 = y
    #  end
    #end
    #puts binding1.nil?
    #binding1
  end
end