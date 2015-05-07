require "cell"

class CellSquared < Cell
  def initialize(row, col)
    super([row, col])
  end

  def row
    position[0]
  end

  def col
    position[1]
  end

  def north
    neighbors[0]
  end

  def north=(cell)
    neighbors[0] = cell
  end

  def east
    neighbors[1]
  end

  def east=(cell)
    neighbors[1] = cell
  end

  def south
    neighbors[2]
  end

  def south=(cell)
    neighbors[2] = cell
  end

  def west
    neighbors[3]
  end

  def west=(cell)
    neighbors[3] = cell
  end
end
