class Speaker
    def initialize(voice: "Samantha")
      @voice = voice
    end
  
    def self.available?
      system("which say > /dev/null 2>&1")
    end
  
    def say(text)
      raise "Command 'say' not available on this system" unless self.class.available?
  
      command = "say -v #{@voice} \"#{text}\""
      system(command)
    end
end
