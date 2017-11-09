class ConnectFour
  MAX_HEIGHT = 6.freeze
  NUM_COLS = 7.freeze

  def initialize
    @turns = 0
    @columns = []
    NUM_COLS.times { @columns << [] }
  end

  def move(column)
    get_column(column) << get_current_player
    @turns += 1
  end

  def get_current_player
    (@turns % 2) + 1
  end

  def get_column(column_index)
    @columns[column_index]
  end

  def connect_four?
    true
  end
end