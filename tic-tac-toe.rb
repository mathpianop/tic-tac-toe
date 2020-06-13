# Fix overwriting poisition
class Board
    @@coordinates = %w(a1 a2 a3 b1 b2 b3 c1 c2 c3)
    @@conversion = {"a"=> 0, "b"=> 1, "c" => 2, "1" => 0, "2" => 1, "3" => 2}

    def initialize(player_1, player_2)
        @player_1 = player_1
        @player_2 = player_2

        @board_array = [%w(- - -), 
                        %w(- - -), 
                        %w(- - -)]

        @victory = false
    end

    def convert_to_coordinates(player_entry)
        player_entry.split("").map! { |x| @@conversion[x]}
    end

    def display
        puts "Board:"
        puts @board_array.map { |x| x.join(" ") }
    end

    def enter_mark(player)
        player_entry = gets.chomp
        player_coordinates = convert_to_coordinates(player_entry)
        coordinate_1 = player_coordinates[0]
        coordinate_2 = player_coordinates[1]
        
        if !@@coordinates.include?(player_entry)
            puts "Please enter a valid position! a2, b1, c3, etc."
            self.enter_mark(player)
        else
            if @board_array[coordinate_1][coordinate_2] != "-"
                puts "That position is already taken!"
                self.enter_mark(player)
            else
                case player_entry
                when "a1"
                    @board_array[0][0] = player.mark
                when "a2"
                    @board_array[0][1] = player.mark
                when "a3"
                    @board_array[0][2] = player.mark
                when "b1"
                    @board_array[1][0] = player.mark
                when "b2"
                    @board_array[1][1] = player.mark
                when "b3"
                    @board_array[1][2] = player.mark
                when "c1"
                    @board_array[2][0] = player.mark
                when "c2"
                    @board_array[2][1] = player.mark
                when "c3"
                    @board_array[2][2] = player.mark
                end        
            end    
        end
    end

    def victory?
        #row victories
        @board_array[0][0] == @board_array[0][1] && 
        @board_array[0][0] == @board_array[0][2] &&
        @board_array[0][0] != "-" ||

        @board_array[1][0] == @board_array[1][1] && 
        @board_array[1][0] == @board_array[1][2] &&
        @board_array[1][0] != "-" ||

        @board_array[2][0] == @board_array[2][1] && 
        @board_array[2][0] == @board_array[2][2] &&
        @board_array[2][0] != "-" ||

        #column victories
        @board_array[0][0] == @board_array[1][0] && 
        @board_array[0][0] == @board_array[2][0] &&
        @board_array[0][0] != "-" ||

        @board_array[0][1] == @board_array[1][1] && 
        @board_array[0][1] == @board_array[2][1] &&
        @board_array[0][1] != "-" ||

        @board_array[0][2] == @board_array[1][2] && 
        @board_array[0][2] == @board_array[2][2] &&
        @board_array[0][2] != "-" ||

        #diagonal victories
        @board_array[0][0] == @board_array[1][1] && 
        @board_array[0][0] == @board_array[2][2] &&
        @board_array[0][0] != "-" ||

        @board_array[0][2] == @board_array[1][1] && 
        @board_array[0][2] == @board_array[2][0] &&
        @board_array[0][2] != "-"

    end

    def check_for_victory
       if self.victory?
        @victory = true
       end
    end

    def play_game
        current_player = @player_1

        while 1
           
            puts "#{current_player.name}, where do you "\
                    "want your #{current_player.mark}?"

            self.enter_mark(current_player)
            self.display
            self.check_for_victory
            if @victory == true
                break
            end

            if current_player == @player_1
                current_player = @player_2
            elsif current_player == @player_2
                current_player = @player_1
            end
        end

        @victor = current_player
        self.display
        puts "Congratulations, #{current_player.name}! You win!"
        
    end
end


class Player
    attr_reader :name, :mark

    def initialize(name, mark)
        @name = name
        @mark = mark
    end
end

#Here goes the initial gameplay setup

puts "Welcome to Tic-Tac-Toe, Game of Champions."

puts "Enter the name of the first player (x):"
player_1 = Player.new(gets.chomp, "x")
puts ""
puts "Welcome, #{player_1.name}!"
puts ""
puts "Enter the name of the second player (o):"
puts ""
player_2 = Player.new(gets.chomp, "o")
puts ""
puts "Welcome, #{player_2.name}!"
puts ""
puts "Here's how it works. When prompted, 
indicate where you want your mark to go 
using a1, b2, etc., like so:"

sample_board = [%w(a1 a2 a3), %w(b1 b2 b3), %w(c1 c2 c3)]
puts sample_board.map { |x| x.join(" ") }
puts ""
puts "Here we go!"
puts ""

board = Board.new(player_1, player_2)
board.display
board.play_game











