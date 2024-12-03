# frozen_string_literal: true

module OsxSayLib
  class Loop
    def initialize
      @speaker = Speaker.new
    end

    def run(sentences: [], inner_delay: 1, outer_delay: 0, times: nil)
      raise ArgumentError, "Parameter 'times' is required" if times.nil?

      (1..times).each do
        sentences.each do |sentence|
          speaker.say(sentence)
          sleep(inner_delay) if inner_delay.to_i.positive?
        end
        sleep(outer_delay) if outer_delay.to_i.positive?
      end
    end

    private

    attr_reader :speaker
  end
end