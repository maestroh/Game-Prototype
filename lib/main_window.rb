require 'gosu'
require_relative 'game/vector2d.rb'
require_relative 'game/ground.rb'
require_relative 'game/scene_object.rb'
require_relative 'game/sprite_sheet.rb'
require_relative 'game/animation.rb'
require_relative 'game/movement.rb'
require_relative 'game/action.rb'
require_relative 'game/animate_object.rb'
require_relative 'game/action_object.rb'
require_relative 'game/scene.rb'
require_relative 'game/key_bindings.rb'
require_relative 'game/key_binding.rb'
require_relative 'game/game.rb'
require_relative 'game/character.rb'
require_relative 'game/statemachine.rb'

class Main_window < Gosu::Window
  def initialize
    super 1024, 768, false
    self.caption = 'The Story of Buck: Chapter 1'
    
    @characters = Hash.new
    init_characters
    
    @background = Gosu::Image.new(self, "../media/background.png", true)
    
    @keystates = Hash.new
    @keystates[Gosu::KbLeft] = {character_id: :buck, character_state: :running, direction: Direction::Left}
    @keystates[Gosu::KbRight] = {character_id: :buck, character_state: :running, direction: Direction::Right}
    @keystates[Gosu::KbUp] = {character_id: :buck, character_state: :jumping, direction: nil}
  end
  
  def init_characters
    @buck = Character.new(@ground = Ground.new(768/2, -1), Vector2d.new(1024/2, 50))
    @buck.add_state(:standing, SpriteSheet.new(self, "../media/guystance.png", 220, 371), Vector2d.new(0,0))
    @buck.add_state(:running, SpriteSheet.new(self, "../media/guyrunning.png", 400, 370), Vector2d.new(10,0))
    @buck.add_state(:jumping, SpriteSheet.new(self, "../media/guyjumping.png", 207, 400), Vector2d.new(0, -20))
    @buck.add_state(:walking, SpriteSheet.new(self, "../media/guywalking.png", 205, 364), Vector2d.new(0,0))
    
    statemachine = Statemachine.new
    statemachine.build do
      transition :standing, :user_running_start, :running
      transition :standing, :user_jumping_start, :jumping
      transition :running, :user_running_stop, :standing
      transition :jumping, :sim_jumping_stop, :standing
    end
    
    @buck.add_statemachine statemachine, :standing, :stand
    
    @characters[:buck] = @buck
  end
  
  def button_down(id)
    if @keystates.has_key? id then
      @characters[@keystates[id][:character_id]].set_direction(@keystates[id][:direction]) unless @keystates[id][:direction].nil?
      @characters[@keystates[id][:character_id]].change_state("user_#{@keystates[id][:character_state]}_start".to_sym) 
    end
  end
  
  def button_up(id)
    if @keystates.has_key? id then
      @characters[@keystates[id][:character_id]].set_direction(@keystates[id][:direction]) unless @keystates[id][:direction].nil?
      @characters[@keystates[id][:character_id]].change_state("user_#{@keystates[id][:character_state]}_stop".to_sym)
    end
  end
  
  def update
    puts "update"
    @characters.each {|id, character| character.update}
  end

  def draw
    puts "draw"
    @characters.each {|id, character| character.draw}
    @background.draw(0,0,ZOrder::Background)
  end
end

window = Main_window.new
window.show
