#lib/hangman.rb

require_relative 'game'


puts "Would you like to play a new game or load?"
puts "Enter 1 to play"
puts "Enter anything else to load"

chosen = gets.chomp

if chosen == "1"
  game = Game.new
  game.play
else
  load_list_path = File.expand_path("../save", File.dirname(__FILE__))
  puts Dir.entries(load_list_path)
  puts "Enter the save file name that you want to load."
  filename = gets.chomp
  file_path = File.expand_path("../save/#{filename}", File.dirname(__FILE__))
  File.open(file_path, 'r') do |file|
    if File.basename(file.path) == filename
      game = Game.from_json(file)
      game.play
    end
  end
end
