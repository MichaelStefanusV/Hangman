#lib/player.rp

class Player
  attr_reader :name

  def initialize (input)
    @name = input.fetch(:name,"Player")
  end

end
