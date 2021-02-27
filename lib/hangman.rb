#lib/hangman.rb

require_relative 'game'


puts "Would you like to play a new game or load?"
puts "Enter 1 to play"
puts "Enter anything else to load"

chose = gets.chomp

if chose == "1"
  game = Game.new
  game.play
else
  load_path = File.expand_path('../save', File.dirname(__FILE__))
  puts Dir.entries(load_path)
  filename = gets.chomp
  fname = File.join(load_path, filename)
  game = Game.from_json(fname)
  game.play
end
