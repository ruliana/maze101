require "cell_squared"
require "chunky_png"

class Grid
  def initialize(rows, cols)
    @rows, @cols = rows, cols
    @grid = prepare_grid
    configure_cells
  end

  def prepare_grid
    Array.new(size) do |index|
      row, col = to_row_col(index)
      CellSquared.new(row, col)
    end
  end

  def configure_cells
    each do |cell|
      row, col = cell.row, cell.col
      cell.north = self[row - 1, col]
      cell.south = self[row + 1, col]
      cell.west = self[row, col - 1]
      cell.east = self[row, col + 1]
    end
  end

  def [](row, col)
    return nil unless row.between?(0, @rows - 1)
    return nil unless col.between?(0, @cols - 1)
    index = to_index(row, col)
    @grid[index]
  end

  def randow_cell
    @grid.sample
  end

  def size
    @rows * @cols
  end

  def each
    @grid.compact.each { |cell| yield cell }
  end

  def each_row
    @rows.times do |row|
      start = row * @cols
      yield @grid[start, @cols]
    end
  end

  def to_row_col(index)
    row = index / @cols
    col = index % @cols
    [row, col]
  end

  def to_index(row, col)
    row * @cols + col
  end

  def to_s
    output = "+" + "---+" * @cols + "\n"
    each_row do |row|
      top = "|"
      bottom = "+"
      row.each do |cell|
        cell = CellSquared.new(-1, -1) unless cell
        body = "   "
        east_boundary = (cell.linked?(cell.east)) ? " " : "|"
        top << body << east_boundary

        south_boundary = (cell.linked?(cell.south)) ? "   " : "---"
        corner = "+"
        bottom << south_boundary << corner
      end
      output << top << "\n"
      output << bottom << "\n"
    end
    output
  end

  def to_png(cell_size: 10)
    img_width = cell_size * @cols
    img_height = cell_size * @rows

    background = ChunkyPNG::Color::WHITE
    wall = ChunkyPNG::Color::BLACK

    img = ChunkyPNG::Image.new(img_width + 1, img_height + 1, background)

    each do |cell|
      x1 = cell.col * cell_size
      y1 = cell.row * cell_size
      x2 = (cell.col + 1) * cell_size
      y2 = (cell.row + 1) * cell_size

      img.line(x1, y1, x2, y1, wall) unless cell.north
      img.line(x1, y1, x1, y2, wall) unless cell.west
      img.line(x2, y1, x2, y2, wall) unless cell.linked?(cell.east)
      img.line(x1, y2, x2, y2, wall) unless cell.linked?(cell.south)
    end
    img
  end

  def inspect
    format "Grid: %d x %d%s", @rows, @cols, @grid.map { |cell| cell.inspect }.join("\n\t")
  end
end
