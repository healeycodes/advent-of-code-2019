filename = ARGV[0]
input = File.open(filename).read

layer_size = 25 * 6
layers = input.chars.each_slice(layer_size).map(&:join)

image_state = array_2 = Array.new(layer_size, nil)

layers.reverse.each { |layer|
    layer.each_char.with_index { |pixel, i|
        if pixel == '2'
            # keep lower layer visible
        elsif pixel == '0'
            image_state[i] = ' '
        else
            image_state[i] = '█'
        end
    }
}

puts image_state.join('').chars.each_slice(25).map(&:join).join("\n")
