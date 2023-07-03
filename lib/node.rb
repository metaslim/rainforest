class Node
  attr_reader :message, :follow

  def initialize(message = nil, follow = nil)
    @message = message
    @follow = follow
  end

  def end?
    message != 'This is not the end'
  end
end