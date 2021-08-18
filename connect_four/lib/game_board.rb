require 'colorize'

class GameBoard
  attr_accessor :data
  def initialize
    @data = Array.new(6*7) { '0' }
  end

  def columns
    columns = Array.new(7) { Array.new }
    for column in (0..6)
      (column...data.size).step(7) { |n| columns[column][n / 7] = data[n] }
    end
    columns
  end

  def rows
    rows = Array.new(6) { Array.new }
    for row in (0...6)
      for n in (0...7)
        rows[row][n] = data[n + row * 7]
      end
    end
    rows
  end

  def diagonals
    diagonals = Array.new(6) { Array.new }
    y = 2
    x = 0
    6.times do |n|
      diag_y = y
      diag_x = x
      until diag_x == 7 || diag_y == 6
        diagonals[n] << data[diag_x + diag_y * 7]
        diag_x += 1
        diag_y += 1
      end
      x += 1 if y.zero?
      y -= 1 unless y.zero?
    end
    diagonals
  end

  def height(column)
    columns[column - 1].reduce(0) do |height, disk|
      return height if disk == '0'
      height += 1
    end
  end

  def column_full(column)
    columns[column - 1][5] != '0'
  end

  def insert_disk(column, player)
    data[height(column) * 7 + column - 1] = player
  end

  def to_s
    string = " O========/888\\========O\n"
    for row in rows.reverse do
      string += " |"
      for disk in row do
        disk_symbol = (disk == '0' ? "\u25CB" : "\u25CF")
        disk_symbol = disk_symbol.yellow if disk == '1'
        disk_symbol = disk_symbol.red if disk == '2'
        string += " #{disk_symbol} "
      end
      string += "|\n"
    end
    string += " |---------------------|\n"
    string += " | 1  2  3  4  5  6  7 |\n"
    string += " =======================\n"
    string += " |_/                 \\_|\n"
    string
  end
end
