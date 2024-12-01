# frozen_string_literal: true

class Counter
  def initialize
    @speaker = Speaker.new
  end

  def countup(times:, delay:, modulo: nil, final: nil)
    (1..times).each do |i|
      speaker.say_async(i) if modulo.nil? || (i % modulo).zero? || times - i < final.to_i || i == 1
      sleep(delay)
    end
  end

  def countdown(times:, delay:, modulo: nil, final: nil)
    times.downto(1).each do |i|
      speaker.say_async(i) if modulo.nil? || (i % modulo).zero? || i <= final.to_i
      sleep(delay)
    end
  end

  private

  attr_reader :speaker
end
