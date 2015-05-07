class Cell
  attr_reader :position
  attr_reader :neighbors

  def initialize(position)
    @position = position
    @links = []
    @neighbors = []
  end

  def link(cell)
    @links << cell
    cell.link_back(self)
    self
  end

  def unlink(cell)
    @links.delete(cell)
  end

  def linked?(cell)
    @links.include?(cell)
  end

  def inspect
    @position.to_s
  end

  protected

  def link_back(cell)
    @links << cell
  end
end
