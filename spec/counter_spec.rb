# frozen_string_literal: true

require 'rspec'
require 'speaker'
require 'counter'

RSpec.describe Counter do
  let(:speaker) { instance_double(Speaker) }
  let(:counter) { described_class.new }

  before do
    allow(Speaker).to receive(:new).and_return(speaker)
    allow(speaker).to receive(:say_async)
    allow_any_instance_of(Counter).to receive(:sleep)
  end

  describe '#countup' do
    context 'when no modulo or final is provided' do
      it 'calls speaker.say_async for all numbers in range' do
        counter.countup(times: 5, delay: 0)
        expect(speaker).to have_received(:say_async).with(1)
        expect(speaker).to have_received(:say_async).with(2)
        expect(speaker).to have_received(:say_async).with(3)
        expect(speaker).to have_received(:say_async).with(4)
        expect(speaker).to have_received(:say_async).with(5)
      end
    end

    context 'when modulo is provided' do
      it 'calls speaker.say_async only for numbers divisible by modulo' do
        counter.countup(times: 10, delay: 0, modulo: 3)
        expect(speaker).to have_received(:say_async).with(1)
        expect(speaker).to have_received(:say_async).with(3)
        expect(speaker).to have_received(:say_async).with(6)
        expect(speaker).to have_received(:say_async).with(9)
        expect(speaker).not_to have_received(:say_async).with(2)
        expect(speaker).not_to have_received(:say_async).with(4)
      end
    end

    context 'when final is provided' do
      it 'calls speaker.say_async for all numbers in the final range' do
        counter.countup(times: 10, delay: 0, modulo: 3, final: 2)
        expect(speaker).to have_received(:say_async).with(1)
        expect(speaker).to have_received(:say_async).with(3)
        expect(speaker).to have_received(:say_async).with(6)
        expect(speaker).to have_received(:say_async).with(9)
        expect(speaker).to have_received(:say_async).with(10)
        expect(speaker).to have_received(:say_async).with(9)
        expect(speaker).not_to have_received(:say_async).with(8)
      end
    end

    context 'when times is 1' do
      it 'calls speaker.say_async once' do
        counter.countup(times: 1, delay: 0)
        expect(speaker).to have_received(:say_async).with(1)
      end
    end

    context 'when delay is set' do
      it 'calls sleep with the correct delay' do
        allow_any_instance_of(Counter).to receive(:sleep)

        counter.countup(times: 3, delay: 0.5)

        expect(counter).to have_received(:sleep).with(0.5).exactly(3).times
      end
    end
  end
  describe '#countdown' do
    context 'when no modulo or final is provided' do
      it 'calls speaker.say_async for all numbers in reverse range' do
        counter.countdown(times: 5, delay: 0)
        expect(speaker).to have_received(:say_async).with(5)
        expect(speaker).to have_received(:say_async).with(4)
        expect(speaker).to have_received(:say_async).with(3)
        expect(speaker).to have_received(:say_async).with(2)
        expect(speaker).to have_received(:say_async).with(1)
      end
    end

    context 'when modulo is provided' do
      it 'calls speaker.say_async only for numbers divisible by modulo' do
        counter.countdown(times: 10, delay: 0, modulo: 3)
        expect(speaker).to have_received(:say_async).with(9)
        expect(speaker).to have_received(:say_async).with(6)
        expect(speaker).to have_received(:say_async).with(3)
        expect(speaker).not_to have_received(:say_async).with(7)
        expect(speaker).not_to have_received(:say_async).with(8)
      end
    end

    context 'when final is provided' do
      it 'calls speaker.say_async for all numbers in the final range' do
        counter.countdown(times: 10, delay: 0, modulo: 5, final: 3)
        expect(speaker).to have_received(:say_async).with(10)
        expect(speaker).to have_received(:say_async).with(5)
        expect(speaker).to have_received(:say_async).with(3)
        expect(speaker).to have_received(:say_async).with(2)
        expect(speaker).to have_received(:say_async).with(1)
        expect(speaker).not_to have_received(:say_async).with(9)
        expect(speaker).not_to have_received(:say_async).with(0)
      end
    end

    context 'when times is 1' do
      it 'calls speaker.say_async once' do
        counter.countdown(times: 1, delay: 0)
        expect(speaker).to have_received(:say_async).with(1)
      end
    end

    context 'when delay is set' do
      it 'calls sleep with the correct delay' do
        allow_any_instance_of(Counter).to receive(:sleep)
        counter.countdown(times: 3, delay: 0.5)
        expect(counter).to have_received(:sleep).with(0.5).exactly(3).times
      end
    end
  end
end
