# frozen_string_literal: true

require 'set'

module OptimizedVersion
  class CodeLock
    def initialize(from:, to:, exclude: [], debug: false)
      @size = from.size
      @from = array_to_i(from)
      @to = array_to_i(to)
      @exclude = exclude.map { |n| array_to_i(n) }.to_set
      @debug = debug
    end

    def call
      @exclude << @from
      find_sequence([[@from]])
    end

    def find_sequence(sequences)
      pp(step: sequences.first.size, sequences_size: sequences.size, exclude: @exclude.size) if @debug

      next_sequences = []
      sequences.each do |sequence|
        find_nearest_combinations(int_to_s(sequence.last)).each do |combination|
          next_sequence = sequence + [combination]
          return next_sequence.map { |num| int_to_a(num) } if combination == @to

          @exclude << combination
          next_sequences << next_sequence
        end
      end

      return if next_sequences.size.zero?

      find_sequence(next_sequences)
    end

    def find_nearest_combinations(combination)
      result = []
      combination.size.times do |index|
        combination_up = rotation_up(combination, index)
        combination_down = rotation_down(combination, index)

        result << combination_up unless @exclude.include?(combination_up)
        result << combination_down unless @exclude.include?(combination_down)
      end
      result
    end

    def rotation_up(combination, index)
      new_combination = combination.dup
      new_combination[index] = next_digit(combination[index])
      new_combination.to_i
    end

    def rotation_down(combination, index)
      new_combination = combination.dup
      new_combination[index] = pred_digit(combination[index])
      new_combination.to_i
    end

    def array_to_i(array)
      array.map(&:to_s).join.to_i
    end

    def int_to_s(num)
      format("%0#{@size}d", num)
    end

    def int_to_a(num)
      int_to_s(num).split('').map(&:to_i)
    end

    def pred_digit(digit)
      digit == '0' ? '9' : digit.ord.pred.chr
    end

    def next_digit(digit)
      digit == '9' ? '0' : digit.next
    end
  end
end
