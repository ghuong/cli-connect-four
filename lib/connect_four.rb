class ConnectFour
  def initialize
    @turns = 0
  end

  def move(column)
    @turns += 1
  end

  def get_current_player
    (@turns % 2) + 1
  end
end