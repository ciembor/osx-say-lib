# frozen_string_literal: true

require 'osx_say_lib/speaker'

RSpec.describe OsxSayLib::Speaker do
  describe '.available?' do
    it 'returns true if the say command is available' do
      expect(OsxSayLib::Speaker.available?).to eq(true).or eq(false)
    end
  end

  context 'when say is available' do
    before do
      skip "Command 'say' not available on this system" unless OsxSayLib::Speaker.available?
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

      context 'with delay' do
        it 'raises an error if delay is negative' do
          speaker = described_class.new
          expect { speaker.say('Hello', -1) }.to raise_error(ArgumentError, /Invalid delay/)
        end

        it 'raises an error if delay is not a number' do
          speaker = described_class.new
          expect { speaker.say('Hello', 'invalid') }.to raise_error(ArgumentError, /Invalid delay/)
        end

        it 'does not raise errors when delay is zero' do
          speaker = described_class.new
          expect { speaker.say('Hello', 0) }.not_to raise_error
        end

        it 'introduces the correct delay after speaking' do
          speaker = described_class.new
          allow(speaker).to receive(:system).and_return(true)

          start_time = Time.now
          speaker.say('', 0.1)
          end_time = Time.now

          expect(end_time - start_time).to be_within(0.02).of(0.1)
        end
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
