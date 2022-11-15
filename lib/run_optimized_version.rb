# frozen_string_literal: true

require_relative 'optimized_version/code_lock'

puts 'example 1'
params = {
  from: [0, 0, 0, 0, 0, 0],
  to: [5, 5, 5, 5, 5, 5],
  exclude: [
    [1, 0, 0, 0, 0, 0], [0, 1, 0, 0, 0, 0], [0, 0, 1, 0, 0, 0], [0, 0, 0, 1, 0, 0], [0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 0, 1],
    [9, 0, 0, 0, 0, 0], [0, 9, 0, 0, 0, 0], [0, 0, 9, 0, 0, 0], [0, 0, 0, 9, 0, 0], [0, 0, 0, 0, 9, 0], [0, 0, 0, 0, 0, 9],
  ]
}

pp params

if (sequence = OptimizedVersion::CodeLock.new(params).call)
  sequence.each { |combination| pp combination }
else
  puts 'нет решения'
end

puts "\nexample 2"
params = {
  from: [0, 0, 0, 0, 0, 0],
  to: [5, 5, 5, 5, 5, 5],
  exclude: [],
  debug: true
}

pp params

if (sequence = OptimizedVersion::CodeLock.new(params).call)
  sequence.each { |combination| pp combination }
else
  puts 'нет решения'
end
