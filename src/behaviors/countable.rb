class Countable < Gemini::Behavior
  attr_accessor :count
  declared_methods :count, :count=, :decrement, :increment
  wrap_with_callbacks :count=
  
  def load
    @count = 0
    @target.enable_listeners_for :incremented
    @target.enable_listeners_for :decremented
  end
  
  def count=(count)
    comparison = @count <=> count 
    @count = count
    case comparison
    when -1
      @target.notify :decremented
    when 0
      # do nothing
    when 1
      @target.notify :incremented
    end
  end
  
  def decrement
    self.count = count - 1
  end
  
  def increment
    self.count = count + 1
  end
end