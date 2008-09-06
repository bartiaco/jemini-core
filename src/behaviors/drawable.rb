class Drawable < Gemini::Behavior
  depends_on_kind_of :Spatial
  declared_methods :draw
  wrap_with_callbacks :draw
  
  def draw(graphics); end
end