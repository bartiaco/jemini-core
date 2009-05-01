class PlayState < Gemini::BaseState
  def load
    set_manager :physics, create_game_object(:BasicPhysicsManager)
    set_manager :tag, create_game_object(:TagManager)
    set_manager :sound, create_game_object(:SoundManager)
    set_manager :tangible, create_game_object(:BasicTangibleManager)
    
    manager(:game_object).add_layer_at :gui_text, 5
    manager(:physics).gravity = 10
    manager(:render).cache_image :tank_body, "tank-body.png"
    manager(:render).cache_image :ground, "ground.png"
    
    load_keymap :PlayKeymap
    
    ground = create_game_object :Ground
    ground.fill_dimensions(0, screen_height / 2, screen_width, screen_height)

    spawner = create_game_object :GameObject, :RecievesEvents
    spawner.handle_event :spawn_thing do
      tank = create_game_object :Tank
      tank.body_position = Vector.new(rand(screen_width), 0)
    end
  end
end