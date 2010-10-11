require 'test/unit'
require 'sudoku_solver'

class SudokuSolverTest < Test::Unit::TestCase
  
  def setup
    @sudoku = <<-SUDOKU 
+-------+-------+-------+
| _ 6 _ | 1 _ 4 | _ 5 _ |
| _ _ 8 | 3 _ 5 | 6 _ _ |
| 2 _ _ | _ _ _ | _ _ 1 |
+-------+-------+-------+
| 8 _ _ | 4 _ 7 | _ _ 6 |
| _ _ 6 | _ _ _ | 3 _ _ |
| 7 _ _ | 9 _ 1 | _ _ 4 |
+-------+-------+-------+
| 5 _ _ | _ _ _ | _ _ 2 |
| _ _ 7 | 2 _ 6 | 9 _ _ |
| _ 4 _ | 5 _ 8 | _ 7 _ |
+-------+-------+-------+
SUDOKU
  
    @solution = <<-SOLUTION 
+-------+-------+-------+
| 9 6 3 | 1 7 4 | 2 5 8 |
| 1 7 8 | 3 2 5 | 6 4 9 |
| 2 5 4 | 6 8 9 | 7 3 1 |
+-------+-------+-------+
| 8 2 1 | 4 3 7 | 5 9 6 |
| 4 9 6 | 8 5 2 | 3 1 7 |
| 7 3 5 | 9 6 1 | 8 2 4 |
+-------+-------+-------+
| 5 8 9 | 7 1 3 | 4 6 2 |
| 3 1 7 | 2 4 6 | 9 8 5 |
| 6 4 2 | 5 9 8 | 1 7 3 |
+-------+-------+-------+
SOLUTION

  @solver =  SudokuSolver.new(@sudoku)

  end

  def test_cells_for_line
    assert_equal (52..77).to_a, @solver.cells_for_line(2)
    cells = @solver.cells_for_line(2)
    assert_equal "| _ _ 8 | 3 _ 5 | 6 _ _ |\n", @solver.string_with_cells(cells)
  end
  
  def test_cells_for_column
    cells = @solver.cells_for_column(4)
    assert_equal "-6__-___-__4-", @solver.string_with_cells(cells)
    assert_equal [6,4], @solver.numbers_in_cells(cells)
  end
  
  def test_cells_for_group
    cells = @solver.cells_for_group(5)
    assert_equal "+-------+| _ _ 6 || 3 _ _ || _ _ 4 |+-------+", @solver.string_with_cells(cells)
    
    cells = @solver.cells_for_group(7)
    assert_equal "+-------+| _ _ _ || 2 _ 6 || 5 _ 8 |+-------+", @solver.string_with_cells(cells)
    
    cells = @solver.cells_for_group(8)
    assert_equal "+-------+| _ _ 2 || 9 _ _ || _ 7 _ |+-------+", @solver.string_with_cells(cells)
  end
  
  def test_numbers_in_cells
    cells = @solver.cells_for_group(5)
    assert_equal [6,3,4], @solver.numbers_in_cells(cells)
  end
  
  def test_solve
    assert_equal @solution, @solver.solve
  end
end
