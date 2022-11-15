# frozen_string_literal: true

require 'slow_version/code_lock'

RSpec.describe SlowVersion::CodeLock do
  subject { described_class.new(from: from, to: to, exclude: exclude).call }

  let(:from) { [0, 0, 0] }
  let(:to) { [1, 1, 1] }
  let(:exclude) { [[0, 0, 1], [1, 0, 0]] }

  let(:result) do
    [
      [0, 0, 0],
      [0, 1, 0],
      [1, 1, 0],
      [1, 1, 1]
    ]
  end

  it { is_expected.to eq(result) }
end
