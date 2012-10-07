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

class Main_window < Gosu::Window
  def initialize
    super 1024, 768, false
    self.caption = 'The Story of Buck: Chapter 1'
    
    @characters = Hash.new
    init_characters
    
    @background = Gosu::Image.new(self, "../media/background.png", true)
    
    @keystates = Hash.new
    @keystates[Gosu::KbLeft] = {character_id: :buck, character_state: :run, direction: Direction::Left}
    @keystates[Gosu::KbRight] = {character_id: :buck, character_state: :run, direction: Direction::Right}
    @keystates[Gosu::KbUp] = {character_id: :buck, character_state: :jump, direction: nil}
    
    # keystates with array as key
    #@keystates = Hash.new
    #@keystates[[Gosu::KbLeft]] = {character_id: :buck, character_state: :run, direction: Direction::Left}
    #@keystates[[Gosu::KbLeft, Gosu::KbUp]] = {character_id: :buck, character_state: :jumprun, direction: Direction::Left}
    #@keystates[[Gosu::KbRight]] = {character_id: :buck, character_state: :run, direction: Direction::Right}
    #@keystates[[Gosu::KbRight, Gosu::KbUp]] = {character_id: :buck, character_state: :jumprun, direction: Direction::Right}
    #@keystates[[Gosu::KbUp]] = {character_id: :buck, character_state: :jump, direction: nil}
  end
  
  def init_characters
    @buck = Character.new(@ground = Ground.new(768/2, -1), Vector2d.new(1024/2, 50))
    @buck.add_state(:default, SpriteSheet.new(self, "../media/guystance.png", 220, 371), Vector2d.new(0,0))
    @buck.add_state(:run, SpriteSheet.new(self, "../media/guyrunning.png", 400, 370), Vector2d.new(10,0))
    @buck.add_state(:jump, SpriteSheet.new(self, "../media/guyjumping.png", 207, 400), Vector2d.new(10, -20))
    @buck.add_state(:walk, SpriteSheet.new(self, "../media/guywalking.png", 205, 364), Vector2d.new(0,0))
    @buck.change_state(:default)
    
    @characters[:buck] = @buck
  end
  
  def button_down(id)
    #@game.update(id)
  end
  
  def update
    @characters.each {|id, character| character.change_state(:default)}
    
    @keystates.each do |key, binding| 
      if button_down? key
        @characters[binding[:character_id]].set_direction(binding[:direction]) unless binding[:direction].nil?
        @characters[binding[:character_id]].change_state(binding[:character_state]) 
      end
    end
    
    @characters.each {|id, character| character.update}
  end

  def draw
    @characters.each {|id, character| character.draw}
    @background.draw(0,0,ZOrder::Background)
  end
end

window = Main_window.new
window.show
