class Scene
  def initialize
    @scene = []
  end
  
  def add_object(object)
    raise TypeError, "Argument expected to support 'draw'" unless object.respond_to? :draw
    raise TypeError, "Argument expected to support 'id'" unless object.respond_to? :id
    @scene << object
  end
  
  def object_ids
    ids = []
    @scene.each {|o| ids << o.id}
    ids
  end
  
  def get_object(id)
    object = @scene.select {|x| x.id == id}[0]
    object
  end
  
  def update(game_object_ID, action_ID)
    object = get_object(game_object_ID)
    object.update(action_ID) unless object.nil? do
       raise ArgumentError, "Object not found"
    end
     
  end
  
  def draw
    @scene.each {|o| o.draw}
  end
end