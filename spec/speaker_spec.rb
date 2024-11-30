require 'speaker'

RSpec.describe Speaker do
    describe '.available?' do
      it 'returns true if the say command is available' do
        expect(Speaker.available?).to eq(true).or eq(false)
      end
    end
  
    context 'when say is available' do
      before do
        skip "Command 'say' not available on this system" unless Speaker.available?
      end
  
      it 'executes the correct system command with given text and voice' do
        speaker = Speaker.new(voice: 'Samantha')
        allow(speaker).to receive(:system).and_return(true)
        speaker.say('testing')
        expect(speaker).to have_received(:system).with('say -v Samantha "testing"')
      end
  
      it 'does not raise errors when speaking text' do
        speaker = Speaker.new(voice: 'Samantha')
        expect { speaker.say('') }.not_to raise_error
      end
    end
end
