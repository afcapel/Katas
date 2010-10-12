[Sodoku Solver (#43)](http://www.rubyquiz.com/quiz43.html) 
===================

Sodokus are simple number puzzles that often appear in various sources of print. The puzzle you are given is a 9 x 9 grid of numbers and blanks, that might look something like this:

<pre>
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
</pre>

The task is to fill in the remaining digits (1 through 9 only) such that each row, column, and 3 x 3 box contains exactly one of each digit. Here's the solution for the above puzzle:

<pre>
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
</pre>

This week's Ruby Quiz is to write a solver that takes the puzzle on STDIN and prints the solution to STDOUT.

SOLUTION
---------

My solution works creating an array of the posible numbers that can be in any position in the sudoku. For any position diferent than '_', the posibilities are just the initial number specified.

For the positions with blanks the posibilities are initially any number from 1 to 9. Then, the posibilities are reduced appliying Sudoku rules:

- A number can not appear twice in any row, column or box.
- Each number must appear once in each row, column and box.

These rules are applied to reduce posibilities until only one number can be in each position. At this point the sudoku is solved.


