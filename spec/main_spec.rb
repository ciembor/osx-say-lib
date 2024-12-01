# frozen_string_literal: true

require 'main'

RSpec.describe Main do
  describe '.run' do
    it 'outputs the init message' do
      expect { Main.run }.to output("Let's work out!\n").to_stdout
    end
  end
end
