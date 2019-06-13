require 'pry'
class TicTacToe
  
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
  [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
   user_input.to_i-1
  end

  def position_taken?(location)
   @board[location] == "X" || @board[location] == "O"
  end

  def move(index, value = "X")
    @board[index] = value
  end

  def valid_move?(index)
    !position_taken?(index) && index.between?(0, 8)
  end

  def current_player
   turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
   if valid_move?(index) == true
    unit = current_player
    move(index, unit)
    display_board
  else
    turn
   end
  end

  def won?
   WIN_COMBINATIONS.each do |element|
     result = []
     element.select{|position| result << @board[position]}
     if result == ["X", "X", "X"] || result == ["O","O","O"]
      return element
      end
     end
    return false
  end

  def full?
   @board.all?{|token| token == "X" || token == "O"}
  end

  def draw?
   !won? && full?
  end

  def over?
   draw? || won? || full?
  end

  def winner
    if won?
      @board[won?.first]
    end
  end

  def play
    while !over?
      turn
  end
   if won?
     puts "Congratulations #{winner}!"
   elsif draw?
     puts "Cat's Game!"
   end
 end
end
