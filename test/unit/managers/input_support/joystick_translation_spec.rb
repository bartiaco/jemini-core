require "spec"
require 'spec_helper'

describe "Keyboard Translation" do
  before do
    @raw_input = mock(:MockContainerInput, :add_listener => nil, :poll => nil)
    @container.stub!(:input).and_return @raw_input
    @input_manager = Jemini::InputManager.new(@state, @container)
    @state.stub!(:manager).with(:input).and_return(@input_manager)
    @message_queue = Jemini::MessageQueue.new(@state)
    @state.stub!(:manager).with(:message_queue).and_return(@message_queue)
    Jemini::GameState.stub!(:active_state).and_return @state
    @state.stub!(:screen_size).and_return Vector.new(640, 480)
    Jemini::InputManager.stub!(:loading_input_manager).and_return @input_manager
  end

  it "translates joystick buttons" do
    lambda do
      Jemini::InputBuilder.declare do |i|
        i.in_order_to :jump do
          i.hold :joystick, :button => 1
        end
      end
    end.should_not raise_error
  end

  it "translates joystick axes" do
    lambda do
      Jemini::InputBuilder.declare do |i|
        i.in_order_to :jump do
          i.move :joystick, :axis => 'x'
        end
      end
    end.should_not raise_error
  end
end