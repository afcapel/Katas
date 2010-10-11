class SudokuSolver
  attr_reader :sudoku

  def self.solve(sudoku)
    SudokuSolver.new(sudoku).solve
  end
  
  def initialize(sudoku)
    @sudoku = sudoku
    populate_posibilites
  end
  
  def populate_posibilites
    @posibilities = []
    0.upto(@sudoku.length-1).each do |i|
      @posibilities[i] = case @sudoku[i]
      when "_"
        (1..9).to_a
      when %r{\d}
        [] << @sudoku[i].to_i
      else
        [] << @sudoku[i]
      end 
    end
  end
  
  def solve
    
    while @sudoku.match "_"
      
      line_length.times do |i|
        col_cells = cells_for_column(i)
        calculate_posibilities_in(col_cells)
      end
      
      num_lines.times do |i|
        line_cells = cells_for_line(i)
        calculate_posibilities_in(line_cells)
      end
      
      9.times do |i|
        group_cells = cells_for_group(i)
        calculate_posibilities_in(group_cells)
      end
      
    end
    
    puts "\nSOLUTION:"
    puts @sudoku
    @sudoku
  end
  
  def cells_for_line(line_num)
    start = line_num * line_length
    finish = (line_num+1) * line_length - 1 # don't include return char
    
    (start..finish).to_a
  end
  
  def cells_for_column(column_line)
    cells = []
    @sudoku.lines.to_a.each_index do |i|
      cells << line_length * i + column_line
    end
    
    cells
  end
  
  def cells_for_group(group_num)
    cells = []
    
    first_line = 4 * (group_num / 3)
    last_line =  first_line + 4
    
    first_column = (group_num %3) * 8
    last_column = first_column + 8
    
    (first_line..last_line).each do |line_num|
      (first_column..last_column).each do |col_num|
        cells << line_num  * line_length + col_num
      end
    end
    
    cells
  end
  
  def numbers_in_cells(cells)
    cells.collect { |c| @posibilities[c][0].to_i if @posibilities[c].size == 1}.delete_if{ |n| n == nil || n == 0 }
  end
  
  def string_with_cells(cells)
    cells.inject("") { |string, i| string + @sudoku[i]}
  end
  
  def calculate_posibilities_in(cells)
    disallow_duplicates_in(cells)
    ensure_all_numbers_are_in(cells)
    
    cells.each do |cell|
      @sudoku[cell] = @posibilities[cell][0].to_s if  @posibilities[cell].size == 1
    end
  end
  
  def disallow_duplicates_in(cells)
    cells.each do |cell|
      next unless  @sudoku[cell] == "_"
      
      numbers_already_taken = numbers_in_cells(cells)
      @posibilities[cell] = @posibilities[cell] - numbers_already_taken
    end
  end
  
  def ensure_all_numbers_are_in(cells)
    already_taken = numbers_in_cells(cells)
    not_taken = (1..9).to_a - already_taken
    
    not_taken.each do |n|
      possible_cells = cells.select { |c| @posibilities[c].include? n }
      if possible_cells.size == 1
        cell = possible_cells[0]
        @posibilities[cell] = [] << n
      end
    end
  end
  
  def line_length
    @sudoku.lines.first.size
  end
  
  def num_lines
    @sudoku.lines.to_a.size
  end
  
end