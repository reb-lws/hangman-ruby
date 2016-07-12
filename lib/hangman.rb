class Hangman
  @attr_reader :badguess_ary, :goodguess_ary

  def initialize(target_word)
    @target_word = target_word
    @goodguess_ary = []
    @badguess_ary = []
    @display = []
    target_word.size.times { @display << "_" }
  end

  def display
    @display.join(" ")
  end
end