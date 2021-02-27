#lib/game.rb

require_relative 'player'

class Game
  
  def initialize(player)
    @player = player
    @word = pick_random()
    @win = false
    @wrong = []
    @answered = []
    @guess = 10
  end

  def play
    while @guess != 0 do
      puts display_word_so_far()
      puts "You have #{@guess} guesses left!!"
      puts "Please enter an alphabet. Answered so far : #{display_answered_word}"
      alp = gets.chomp
      check_answer(alp)
      if iswin?()
        "You've won!!"
        @word = pick_random()
        @win = false
        @wrong = []
        @answered = []
        @guess = 10
        break
      end
      @guess = @guess - 1
    end
    "You lose!!"
    @word = pick_random()
    @win = false
    @wrong = []
    @answered = []
    @guess = 10
  end

  private

  def check_answer(word)

    if is_valid?(word)

      if @answered.include?(word) 
        "You have entered that word!"
      elsif @word.split("").include?(word)
        @answered << word.downcase
      else
        @wrong << word.upcase
      end

    else
      "Invalid answer!"
    end
  
  end

  def is_valid?(word)
    result = false
    if word.length == 1 && word.match(/^[A-Za-z]+$/)
      result = true
    end
    result
  end

  def display_answered_word
    arr = @answered + @wrong
    result = ""
    arr.each do |word|
      result += word + " "
    end
    puts result
    result
  end

  def display_word_so_far
    result = ""
    arr = @word.split("")
    arr.each_with_index do |word, id|
      if @answered.include?(word)
        result += word
      else
        result += "_"
      end
    end
    result
  end


  def pick_random
    
    file = File.open("../testList.txt", "r")
    arr = Array.new
    
    while !file.eof?
      line = file.readline
      arr << line
    end
    
    file.close
    
    chosen = arr.sample
    chosen
  end

  def iswin?
    result = false
    arr_key = @word.split("").uniq
    if arr_key.length == @answered.length
      result = true
    end
    result
  end

end

player = Player.new(name:"raka")
game = Game.new(player)
game.play
