#Makes an object draw itself on the screen as a polygon.
class DrawableShape < Jemini::Behavior
  java_import 'org.newdawn.slick.geom.Vector2f'
  java_import 'org.newdawn.slick.geom.Polygon'
  java_import 'org.newdawn.slick.geom.Circle'

  depends_on :Spatial
  wrap_with_callbacks :draw

  attr_accessor :color, :image
  attr_reader :visual_shape


  #Set the shape to draw.
  #Accepts :Polygon or the name of a class in the DrawableShape namespace.
  #TODO: There are no DrawableShape::* classes yet!
  def set_visual_shape(shape, *params)
    case shape
    when :polygon, :Polygon
      @visual_shape = "#{self.class}::#{shape}".constantize.new
      params.each do |vector|
        @visual_shape.add_point vector.x, vector.y
      end
    when :circle, :Circle
      @visual_shape = DrawableShape::Circle.new(position.x, position.y, params)
    else
      @visual_shape = ("DrawableShape::"+ shape.to_s).constantize.new(params)
    end
  end
  
  #Takes a reference to an image loaded via the resource manager, and sets the bitmap.
  def image=(reference)
    @image = game_state.manager(:resource).get_image(reference)
  end
  alias_method :set_image, :image=

  def draw(graphics)
    if @visual_shape.kind_of? Polygon
      #TODO: Tweak these values!!!!
      #@image.width.to_f / game_state.screen_width.to_f, @image.height.to_f / game_state.screen_height.to_f
      graphics.texture @visual_shape, @image, 1.0 / @image.width.to_f, 1.0 / @image.height.to_f
    else
      raise "#{@visual_shape.class} is not supported"
    end
  end
end