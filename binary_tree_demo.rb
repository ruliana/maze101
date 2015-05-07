require "grid"
require "binary_tree"

grid = Grid.new(15, 30)
BinaryTree.on(grid)
#grid.to_png.save "maze.png"
puts grid.to_s
