class Point
  attr_reader :start_coord, :start_x, :start_y, :name, :board_x_max, :board_y_max
  attr_accessor :outward_steps

  def initialize(start_coord:, name:, board_x_max:, board_y_max:)
    @start_coord = start_coord
    @name = name
    @board_x_max = board_x_max
    @board_y_max = board_y_max
    @start_x = start_coord[0]
    @start_y = start_coord[1]
    @outward_steps = 0
  end

  def emit_new_coords
    coords = select_coords_from_set(coord_set: build_coord_spiral)
    @outward_steps += 1
    coords
  end

  private

  def select_coords_from_set(coord_set:)
    coord_set.select { |x, y| x >= 0 && x < board_x_max && y >= 0 && y < board_y_max }.uniq
  end

  def build_coord_spiral
    initial_set = build_cross
    return initial_set if initial_set.any? { |set| set == start_coord }

    all_coords = []

    0.upto(3) do |i|
      current_coords = initial_set[i]
      comparison_coords = initial_set[i + 1] || initial_set[0]

      x_counter = 0
      y_counter = 0

      all_coords << current_coords

      until comparison_coords == all_coords.last
        if i == 0
          x_counter -= 1
          y_counter += 1
        elsif i == 1
          x_counter -= 1
          y_counter -= 1
        elsif i == 2
          x_counter += 1
          y_counter -= 1
        elsif i == 3
          x_counter += 1
          y_counter += 1
        end

        all_coords << [ (current_coords[0] + x_counter), (current_coords[1] + y_counter) ]
      end
    end

    all_coords
  end

  def build_cross
    [
      [start_x + outward_steps, start_y],
      [start_x, start_y + outward_steps],
      [start_x - outward_steps, start_y],
      [start_x, start_y - outward_steps]
    ]
  end
end
