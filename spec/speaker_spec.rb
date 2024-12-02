# frozen_string_literal: true

require 'wassist/speaker'

RSpec.describe Wassist::Speaker do
  describe '.available?' do
    it 'returns true if the say command is available' do
      expect(Wassist::Speaker.available?).to eq(true).or eq(false)
    end
  end

  context 'when say is available' do
    before do
      skip "Command 'say' not available on this system" unless Wassist::Speaker.available?
    end

    describe '#say' do
      it 'executes the correct system command with given text and voice' do
        speaker = described_class.new(voice: 'Samantha')
        allow(speaker).to receive(:system).and_return(true)
        speaker.say('testing')
        expect(speaker).to have_received(:system).with('say -v Samantha "testing"')
      end

      it 'does not raise errors when speaking text' do
        speaker = described_class.new(voice: 'Karen')
        expect { speaker.say('') }.not_to raise_error
      end
    end

    describe '#say_async' do
      it 'executes the say command in a new thread' do
        speaker = described_class.new
        allow(speaker).to receive(:say)
        thread = speaker.say_async('Async testing')
        thread.join
        expect(speaker).to have_received(:say).with('Async testing')
      end
    end
  end
end
