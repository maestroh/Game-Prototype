class Vector2d
  attr_accessor :x
  attr_accessor :y

  def initialize(x, y)
    @x = x 
    @y = y
  end

  def ==(vector)
    ( vector.x == @x && vector.y == y )
  end

  def +(vector)
    Vector2d.new(@x+vector.x, @y+vector.y)
  end

  def -(vector)
    Vector2d.new(@x-vector.x, @y-vector.y)
  end
end
