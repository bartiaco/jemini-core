#Makes an object attract other Physical game objects towards it.
class Magnetic < Gemini::Behavior
  depends_on :Physical
  
  #The force to exert.  0 means no push.
  attr_accessor :magnetism
  alias_method :set_magnetism, :magnetism=
  
  #There is no effect on targets that are beyond this distance.
  attr_accessor :magnetism_max_radius
  alias_method :set_magnetism_max_radius, :magnetism_max_radius=

  #The distance where force progression is cut off. Distances closer than this will be treated as if it were the distance provided
  attr_accessor :magnetism_min_radius
  alias_method :set_magnetism_min_radius, :magnetism_min_radius=

  def load
    @magnetism = 0.0
    @magnetism_max_radius = 0.0
    @magnetism_min_radius = 0.0
    @target.on_update do |delta|
      physicals = @target.game_state.manager(:game_object).game_objects.select {|game_object| game_object.kind_of? Physical}
      physicals.each do |physical|
        next if @target == physical
        distance = @target.position.distance_from physical
        next if distance > @magnetism_max_radius
        distance = @magnetism_min_radius if distance < @magnetism_min_radius
        force = delta * @magnetism / (distance * Gemini::Math::SQUARE_ROOT_OF_TWO)
        magnetism = Vector.from_polar_vector(force, physical.position.angle_from(@target))
        physical.add_force magnetism
      end
    end
  end
end
