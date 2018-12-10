class FabricSlicer
  attr_reader :inputs
  attr_accessor :sub_rectangles, :cloth

  def initialize(inputs:, cloth_size:)
    @inputs = inputs
    @cloth_size = cloth_size
    @cloth = Array.new(cloth_size) { Array.new(cloth_size) }
    translate_inputs_to_sub_rectangles
  end

  def translate_inputs_to_sub_rectangles
    @sub_rectangles = inputs.map { |input| translate_to_rectangle(input: input) }
  end

  def map_to_cloth
    sub_rectangles.each do |rectangle_set|
      (rectangle_set[:min_y] .. rectangle_set[:max_y]).each do |y_coord|
        (rectangle_set[:min_x] .. rectangle_set[:max_x]).each do |x_coord|
          @cloth[y_coord][x_coord] = cloth[y_coord][x_coord].nil? ? rectangle_set[:id] : 'o'
        end
      end
    end
    pretty_print_cloth
  end

  def count_overlaps
    overlap_counter = 0
    cloth.each { |row| overlap_counter += row.count { |col| col == 'o' } }
    overlap_counter
  end

  def find_non_overlap_id
    sub_rectangles.each do |rectangle|
      found = check_cloth_for_rectangle(rectangle: rectangle)
      return rectangle[:id] if found
    end
    false
  end

  private

  def translate_to_rectangle(input:)
    min_x_and_y = input.match(/\@\s(.*)\:/).captures.first.split(',').map(&:to_i)
    add_to_x_and_y = input.match(/\:\s(.*)\z/).captures.first.split('x').map(&:to_i)
    id = input.match(/\A\#(.*)\s\@/).captures.first

    {
      id: id,
      min_x: min_x_and_y[0],
      min_y: min_x_and_y[1],
      max_x: min_x_and_y[0] + (add_to_x_and_y[0] - 1),
      max_y: min_x_and_y[1] + (add_to_x_and_y[1] - 1)
    }
  end

  def pretty_print_cloth
    @cloth.map do |row|
      row = row.map { |column| column.nil? ? '.' : column }.join('')
      puts row
      row
    end
  end

  def check_cloth_for_rectangle(rectangle:)
    id = rectangle[:id]
    (rectangle[:min_y] .. rectangle[:max_y]).each do |y_coord|
      (rectangle[:min_x] .. rectangle[:max_x]).each do |x_coord|
        return false if cloth[y_coord][x_coord] != rectangle[:id]
      end
    end
    true
  end
end
