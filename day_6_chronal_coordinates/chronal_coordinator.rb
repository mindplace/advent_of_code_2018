require_relative 'point'

class ChronalCoordinator
  attr_reader :board_size, :points_inputs
  attr_accessor :board, :points

  def initialize(board_size:, points_inputs:)
    @board_size = board_size
    @board = []
    @points_inputs = points_inputs
    @points = build_points
    @board = build_board
    populate_board_with_points
  end

  def calibrate_points
    until filled?
      full_new_coords = points.map { |point| [ point.name, point.emit_new_coords ] }.to_h
      just_coords = full_new_coords.values.flatten(1)
      point_groups = just_coords.group_by { |coord| just_coords.count(coord) }
      point_groups.each do |count, group|
        if count == 1
          group.each do |coord|
            point_name = full_new_coords.find { |name, group| group.include?(coord) }.first
            @board[coord[0]][coord[1]] = point_name if @board[coord[0]][coord[1]].nil?
          end
        else
          group.each do |coord|
            @board[coord[0]][coord[1]] = '.' if @board[coord[0]][coord[1]].nil?
          end
        end
      end
      pretty_print_board
      binding.pry
    end
  end

  private

  def build_points
    points_inputs.map.with_index { |coord, i| Point.new(start_coord: coord, name: i.to_s, board_size: board_size) }
  end

  def build_board
    Array.new(board_size) { Array.new(board_size) }
  end

  def populate_board_with_points
    points.each { |point| @board[point.start_x][point.start_y] = point.name }
  end

  def filled?
    board.flatten(1).none?(&:nil?)
  end

  def pretty_print_board
    board.each do |row|
      puts row.map { |col| col.nil? ? "-" : col }.join("")
    end
  end
end
