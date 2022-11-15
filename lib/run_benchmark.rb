# frozen_string_literal: true

require 'benchmark'

require_relative 'optimized_version/code_lock'
require_relative 'slow_version/code_lock'

params = {
  from: [0, 0, 0, 0, 0, 0],
  to: [5, 5, 5, 5, 5, 5],
  exclude: []
}

Benchmark.bm(20) do |x|
  x.report('slow_version:')       { SlowVersion::CodeLock.new(params).call }
  x.report('optimized_version:')  { OptimizedVersion::CodeLock.new(params).call }
end
