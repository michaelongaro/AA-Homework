class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
      @sequence_length = 1
      @game_over = false
      @seq = []
  end

  def play
      while !@game_over
          take_turn

      end
      game_over_message
      reset_game
  end

  def take_turn
      if !@game_over
        round_success_message
        show_sequence
        require_sequence
        @sequence_length += 1
      end
  end

  def show_sequence
      add_random_color
  end

  def require_sequence

  end

  def add_random_color
      @seq << COLORS[Random.rand(5)]
  end

  def round_success_message
      puts " was correct! continue playing."
  end 

  def game_over_message
      puts " was incorrect! please try again."
  end

  def reset_game
      @sequence_length = 1
      @game_over = false
      @seq = []
  end
end
