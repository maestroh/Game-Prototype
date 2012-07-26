require 'gosu'
require_relative 'game/scene_object.rb'
require_relative 'game/sprite_sheet.rb'
require_relative 'game/animation.rb'
require_relative 'game/animate_object.rb'
require_relative 'game/scene.rb'
require_relative 'game/key_bindings.rb'
require_relative 'game/key_binding.rb'
require_relative 'game/game.rb'

class Main_window < Gosu::Window
  def initialize
    super 1024, 768, false
    self.caption = 'The Story of Buck: Chapter 1'
    @scene = Scene.new
    @key_bindings = KeyBindings.new
    
    load_images
    load_scene
    load_keybindings
    
    @game = Game.new(@scene, @key_bindings)
  end
  
  def load_images
     @background = Gosu::Image.new(self, "../media/background.png", true)
  end
    
  def load_scene
    background = SceneObject.new("background", @background)
    @scene.add_object  background
    
    buck = AnimateObject.new("buck")
    buck.add_animation(Animation.new("buck_stance", SpriteSheet.new(self, "../media/guystance.png", 220, 371)))
    buck.add_animation(Animation.new("buck_run", SpriteSheet.new(self, "../media/guyrunning.png", 400, 370)))
    buck.add_animation(Animation.new("buck_jump", SpriteSheet.new(self, "../media/guyjumping.png", 207, 400)))
    buck.add_animation(Animation.new("buck_walk", SpriteSheet.new(self, "../media/guywalking.png", 205, 364)))
    buck.perform_animation("buck_stance")
    buck.warp(1024/2, 768/2)
    @scene.add_object buck
  end

  def load_keybindings
    run = KeyBinding.new [Gosu::KbRight], "buck", "buck_run"
    @key_bindings.add_binding run
  end 

  def button_down(id)
    @game.update(id)
  end

   def draw
    @scene.draw
  end
end

window = Main_window.new
window.show