# frozen_string_literal: true

require 'wassist/loop'

RSpec.describe Wassist::Loop do
  let(:speaker) { instance_double('Wassist::Speaker') }
  let(:loop_instance) { described_class.new }

  before do
    allow(Wassist::Speaker).to receive(:new).and_return(speaker)
    allow(speaker).to receive(:say)
  end

  describe '#run' do
    context 'when times is nil' do
      it 'raises an ArgumentError' do
        expect do
          loop_instance.run(sentences: ['Hello'], times: nil)
        end.to raise_error(ArgumentError, "Parameter 'times' is required")
      end
    end

    context 'when times is provided' do
      it 'calls Speaker#say the correct number of times' do
        loop_instance.run(sentences: ['Hello'], times: 2, inner_delay: 0, outer_delay: 0)
        expect(speaker).to have_received(:say).with('Hello').twice
      end

      it 'sleeps for the inner delay between sentences' do
        expect(loop_instance).to receive(:sleep).with(1).exactly(2).times
        loop_instance.run(sentences: %w[Hello World], times: 1, inner_delay: 1, outer_delay: 0)
      end

      it 'sleeps for the outer delay between iterations' do
        expect(loop_instance).to receive(:sleep).with(2).exactly(2).times
        loop_instance.run(sentences: ['Hello'], times: 2, inner_delay: 0, outer_delay: 2)
      end
    end

    context 'with multiple sentences' do
      it 'calls Speaker#say for each sentence in the correct order' do
        loop_instance.run(sentences: %w[First Second], times: 1, inner_delay: 0, outer_delay: 0)
        expect(speaker).to have_received(:say).with('First').ordered
        expect(speaker).to have_received(:say).with('Second').ordered
      end
    end
  end
end
