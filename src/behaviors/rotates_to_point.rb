# This behavior rotates to face the tracking point or game object.
class RotatesToPoint < Jemini::Behavior
  #TODO: Add offset rotation
  depends_on :Physical
  attr_accessor :rotation_target
  alias_method :set_rotation_target, :rotation_target=
  
  def load
    @game_object.on_update do
      @game_object.set_rotation rotation_to_face_target if @rotation_target
    end
  end
  
  #The angle that the object must turn to face the rotation_target.
  def rotation_to_face_target
    #TODO: Use vector
    diff_angle = Jemini::Math.radians_to_degrees Math.atan2(@game_object.y - @rotation_target.y, @game_object.x - @rotation_target.x)
  end
end