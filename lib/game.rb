#lib/game.rb

require 'json'

class Game
  
  def initialize(word = pick_random(), win = false, wrong = [], answered = [], guess = 10)
    @word = word
    @win = win
    @wrong = wrong
    @answered = answered
    @guess = guess
  end

  def play
    while @guess != 0 do
      puts display_word_so_far()
      puts "You have #{@guess} guesses left!!"
      puts "Please enter an alphabet. Answered so far : #{display_answered_word}"
      alp = gets.chomp
      check_answer(alp)
      break if alp.downcase == "save"
      if iswin?()
        puts "You've won!!"
        @word = pick_random().chomp
        @win = false
        @wrong = []
        @answered = []
        @guess = 10
        break
      end
      @guess = @guess - 1
    end
    if @guess == 0
      puts "You lose!!"
      puts "The word is #{@word}"
      @word = pick_random()
      @win = false
      @wrong = []
      @answered = []
      @guess = 10
    end
    puts "Thank you for playing!!"
  end

  def save(filename)
    save_path = File.expand_path('../save', File.dirname(__FILE__))
    fname = File.join(save_path, "#{filename}.json")
    dump = to_json
    file = File.open(fname, "w") do |f|
      f.write(dump)
    end
  end

  private

  def check_answer(word)
    if word.downcase == "save"
      puts "Enter a name for your save file"
      name = gets.chomp
      save(name)
      puts "File saved"
    else
      if is_valid?(word)
        if @answered.include?(word) 
          puts "You have entered that word!"
          @guess += 1
        elsif @word.split("").include?(word)
          @answered << word.downcase
        else
          @wrong << word.upcase
        end
      else
        puts "Invalid answer!"
        @guess += 1
      end
    end
  end

  def to_json
    JSON.dump({
      :word => @word,
      :win => @win,
      :wrong => @wrong,
      :answered => @answered,
      :guess => @guess
    })
  end

  def self.from_json(string)
    data = JSON.load string
    self.new( 
      data['word'], 
      data['win'],
      data['wrong'],
      data['answered'],
      data['guess']
    )
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
    
    file = File.open("testList.txt", "r")
    arr = Array.new
    
    while !file.eof?
      line = file.readline
      arr << line
    end
    
    file.close
    
    chosen = arr.sample
    len = chosen.length
    chosen = chosen[0..(len-2)]
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