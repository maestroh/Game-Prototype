require_relative "direction.rb"

class Character
  def initialize(ground, start_position)
    @ground = ground
    @states = Hash.new
    
    @x = start_position.x
    @y = start_position.y
    @vx = 0
    @vy = 0
    
    @direction = Direction::Right
  end
  
  def add_state(state_id, sprite_sheet, move_vector)
    state = {sprite_sheet: sprite_sheet, move_vector: move_vector}
    
    @states[state_id] = state
  end
  
  def add_statemachine(statemachine, initial_state, default_event)
    @statemachine = statemachine
    
    @current_state_id = initial_state
    @default_event = default_event 
  end
  
  def states
    @states.keys
  end
  
  def change_state(event)
    output_state = @statemachine.output_state(@current_state_id, event)
    @current_state_id = output_state unless output_state.nil?
  end
  
  def in_state
    @current_state_id
  end
  
  def set_direction(direction)
    @direction = direction
  end
  
  def update
    move_vector = @states[@current_state_id][:move_vector]
    @vx = move_vector.x 
    
    if @ground.on_ground?(@y) then
      @vy = move_vector.y
    end
    
    if done then
      change_state(@default_event)
    end
  end
  
  def done
    @states[@current_state_id][:sprite_sheet].done && @ground.on_ground(@y)
  end
  
  def draw
    @x += @vx * @direction
    @vx = 0
    
    if @vy != 0 || @ground.above_ground?(@y)
      @y += @vy
      @vy -= @ground.get_gravity
    end
    
    if @ground.below_ground?(@y)
      @y = @ground.get_height
      @vy = 0
    end 
    
    img = @states[@current_state_id][:sprite_sheet].image
    x_upperleft = @x - img.width / 2.0 * @direction
    y_upperleft = @y - img.height / 2.0
    img.draw(x_upperleft, y_upperleft , ZOrder::Character, @direction, 1, Gosu::Color.new(0xffffffff), :default)
  end
end