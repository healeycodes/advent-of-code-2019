filename = ARGV[0]
input = File.open(filename).read
layer_size = 25 * 6

layers = input.chars.each_slice(layer_size).map(&:join)
layers = layers.sort_by{ |layer| layer.count('0') }

puts layers[0].count('1') * layers[0].count('2')
