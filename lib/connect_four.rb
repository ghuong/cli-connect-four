class ConnectFour
  MAX_HEIGHT = 6.freeze
  NUM_COLS = 7.freeze

  attr_reader :columns

  def initialize
    @turns = 0
    @columns = []
    NUM_COLS.times { @columns << [] }
  end

  def move(column_index)
    if not (0...NUM_COLS).cover? column_index then return false end
    if columns[column_index].length >= MAX_HEIGHT then return false end

    columns[column_index] << get_current_player
    @turns += 1
  end

  def get_current_player
    (@turns % 2) + 1
  end

  def connect_four?(last_played_column_index)
    return (connect_four_vertical?(last_played_column_index) or 
      connect_four_horizontal?(last_played_column_index) or 
      connect_four_diagonally_down?(last_played_column_index) or
      connect_four_diagonally_up?(last_played_column_index))
  end

  def connect_four_vertical?(last_played_column_index)
    block = @columns[last_played_column_index][-4..-1]
    if block.nil? then return false end
    return block.all? { |player| player == block[-1] }
  end

  def connect_four_horizontal?(last_played_column_index)
    false
  end

  def connect_four_diagonally_down?(last_played_column_index)
    false
  end

  def connect_four_diagonally_up?(last_played_column_index)
    false
  end
end