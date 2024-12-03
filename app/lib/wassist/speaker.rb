# frozen_string_literal: true

module OsxSayLib
  class Speaker
    def initialize(voice: 'Karen')
      @voice = voice
    end

    def self.available?
      system('which say > /dev/null 2>&1')
    end

    def say(text)
      raise "Command 'say' not available on this system" unless self.class.available?

      command = "say -v #{@voice} \"#{text}\""
      system(command)
    end

    def say_async(text)
      Thread.new do
        say(text)
      end
    end
  end
end
