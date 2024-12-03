# frozen_string_literal: true

module OsxSayLib
  class Speaker
    def initialize(voice: 'Karen')
      @voice = voice
    end

    def self.available?
      system('which say > /dev/null 2>&1')
    end

    def say(text, delay = 0)
      unless delay.is_a?(Numeric) && delay >= 0
        raise ArgumentError,
              "Invalid delay: #{delay}. Delay must be a non-negative number."
      end
      raise "Command 'say' not available on this system" unless self.class.available?

      command = "say -v #{@voice} \"#{text}\""
      system(command)
      sleep(delay) if delay.positive?
    end

    def say_async(text)
      Thread.new do
        say(text)
      end
    end
  end
end
