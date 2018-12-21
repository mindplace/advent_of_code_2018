require_relative 'point'

class ChronalCoordinator
  attr_reader :board_size, :points_inputs, :starting_x, :starting_y, :ending_x, :ending_y
  attr_accessor :board, :points

  def initialize(board_size:, points_inputs:)
    @board_size = board_size
    @board = []
    @points_inputs = points_inputs
    @board = build_board
    populate_board_with_points
    abbreviate_board
    @points = build_points
  end

  def calibrate_points
    counter = 0
    until filled?
      counter += 1
      full_new_coords = points.map { |point| [ point.name, point.emit_new_coords ] }.to_h
      just_coords = full_new_coords.values.flatten(1)
      point_groups = just_coords.partition { |coord| just_coords.count(coord) == 1 }

      singular = point_groups[0]
      multiples = point_groups[1]

      multiples.each do |x, y|
        if board[x]
          @board[x][y] = '.' if @board[x][y].nil?
        end
      end

      singular.each do |x, y|
        if board[x]
          point_name = full_new_coords.find { |name, group| group.include?([x, y]) }.first
          @board[x][y] = point_name if @board[x][y].nil?
        end
      end
    end
    puts counter
    pretty_print_board
  end

  def count_largest_area
    calibrate_points
    points_to_ignore = build_ignore_points_array
    countable_elements = board.flatten.reject { |el| el == '.' || points_to_ignore.include?(el) }
    countable_elements.group_by { |el| countable_elements.count(el) }.sort_by { |k, v| k }.last[0]
  end

  private

  def build_points
    points_inputs.map.with_index { |coord, i| Point.new(start_coord: coord, name: i.to_s, board_x_max: ending_x, board_y_max: ending_y) }
  end

  def build_board
    initial_board = Array.new(board_size) { Array.new(board_size) }
  end

  def populate_board_with_points
    points_inputs.each_with_index do |coords, i|
      x = coords[0]
      y = coords[1]
      @board[x][y] = i.to_s
    end
  end

  def abbreviate_board
    board.each_with_index do |row, i|
      next if row.all?(&:nil?)
      @starting_x = i
      break
    end

    board.transpose.each_with_index do |col, i|
      next if col.all?(&:nil?)
      @starting_y = i
      break
    end

    board.reverse.each_with_index do |row, i|
      next if row.all?(&:nil?)
      @ending_x = board.length - i - 1
      break
    end

    board.transpose.reverse.each_with_index do |col, i|
      next if col.all?(&:nil?)
      @ending_y = board.length - i - 1
      break
    end

    @board = board[starting_x .. ending_x]
    @board = board.map { |row| row[starting_y .. ending_y] }
    @points_inputs = board.map.with_index { |row, i| row.map.with_index { |col, j| col.nil? ? col : [i, j] }.compact }.flatten(1)
  end

  def filled?
    board.flatten(1).none?(&:nil?)
  end

  def pretty_print_board
    board.map do |row|
      row.map { |col| col.nil? ? "-" : col }.join("")
    end
  end

  def build_ignore_points_array
    items_to_ignore = []
    items_to_ignore << board[0]
    items_to_ignore << board[-1]
    transposed = board.transpose
    items_to_ignore << transposed[0]
    items_to_ignore << transposed[-1]
    items_to_ignore.flatten.reject { |el| el == '.' }.uniq
  end
end
