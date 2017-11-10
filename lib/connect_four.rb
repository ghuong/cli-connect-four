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
    if not is_valid_column? column_index then return false end
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
    height = @columns[last_played_column_index].length
    return false if height <= 0
    connected = 1
    check_row = Proc.new do |i|
      ith_column_index = last_played_column_index + i
      next if not is_valid_column? ith_column_index
      ith_column = @columns[ith_column_index]
      next if ith_column.length < height or
        ith_column[height] != @columns[last_played_column_index][height]
      connected += 1
    end
    # check for matching pieces to the left
    -1.downto(-3).each(&check_row)
    # check for matching pieces to the right
    1.upto(3).each(&check_row)
    return connected >= 4
  end

  def connect_four_diagonally_down?(last_played_column_index)
    false
  end

  def connect_four_diagonally_up?(last_played_column_index)
    false
  end

  def is_valid_column?(column_index)
    (0...NUM_COLS).cover? column_index
  end
end