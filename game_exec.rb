Dir["lib/*.rb"].each { |file| require_relative file }

puts "Enter the first player's name, the player will start as the codemaker:"
name1 = gets.chomp
puts "Is the player AI controlled? (Y)"
ai1 = (gets.chomp.upcase == 'Y') ? :AI : false

puts "Enter the second player's name, the player will start as the codebreaker:"
name2 = gets.chomp
puts "Is the player AI controlled? (Y)"
ai2 = (gets.chomp.upcase == 'Y') ? :AI : false

player1 = Player.new(name1, ai1)
player2 = Player.new(name2, ai2)

Game.new(players: [player1, player2], board: Board.new(12)).play