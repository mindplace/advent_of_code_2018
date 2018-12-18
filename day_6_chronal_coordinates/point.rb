class Point
  attr_reader :start_coord, :start_x, :start_y, :name
  attr_accessor :outward_steps

  def initialize(start_coord:, name:)
    @start_coord = start_coord
    @name = name
    @start_x = start_coord[0]
    @start_y = start_coord[1]
    @outward_steps = 0
  end

  def emit_new_coords
    inner_steps = outward_steps
    @outward_steps += 1

    outward_coords = select_coords_from_set(coord_set: build_cross(steps: outward_steps))
    inner_coords = select_coords_from_set(coord_set: build_square(steps: inner_steps))

    outward_coords + inner_coords
  end

  private

  def select_coords_from_set(coord_set:)
    coord_set.select { |x, y| x >= 0 && x <= 360 && y >= 0 && y<= 360 }.uniq
  end

  def build_square(steps:)
    return [] if steps == 0
    nums_for_coords = build_cross(steps: steps).flatten.sort.select.with_index { |el, i| i == 0 || i == 7 }
    result_coords = []
    nums_for_coords.each { |el| result_coords << [el, el]}
    result_coords + nums_for_coords.permutation(2).to_a
  end

  def build_cross(steps:)
    [
      [start_x - steps, start_y],
      [start_x + steps, start_y],
      [start_x, start_y + steps],
      [start_x, start_y - steps]
    ]
  end
end
