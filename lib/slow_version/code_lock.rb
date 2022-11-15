# frozen_string_literal: true

require 'set'

module SlowVersion
  class CodeLock
    def initialize(from:, to:, exclude: [], debug: false)
      @from = from
      @to = to
      @exclude = exclude.to_set
      @debug = debug
    end

    def call
      @exclude << @from
      find_sequence([[@from]])
    end

    private

    def find_sequence(sequences)
      pp(step: sequences.first.size, sequences_size: sequences.size, exclude: @exclude.size) if @debug

      next_sequences = []
      sequences.each do |sequence|
        find_nearest_combinations(sequence.last).each do |combination|
          next_sequence = sequence + [combination]
          return next_sequence if combination == @to

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
      combination.clone.tap do |new_combination|
        new_combination[index] = combination[index] + 1 > 9 ? 0 : combination[index] + 1
      end
    end

    def rotation_down(combination, index)
      combination.clone.tap do |new_combination|
        new_combination[index] = (combination[index] - 1).negative? ? 9 : combination[index] - 1
      end
    end
  end
end
