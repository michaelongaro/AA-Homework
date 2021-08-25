class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14, 0)

    place_stones
  end

  def place_stones
    @cups.each_with_index do |cup, i|
        if i != 6 && i != 13
            @cups[i] = 4
        end
    end
  end

  def valid_move?(start_pos)
     raise "Invalid starting cup" if start_pos < 0 || start_pos > 13
     raise "Starting cup is empty" if @cups[start_pos] == 0
  end

  def make_move(start_pos, current_player_name)
      @temp_stones = @cups[start_pos]
      @cups[start_pos] = 0

      cup_idx = start_pos

      while @temp_stones > 0
          cup_idx += 1
          cup_idx = 0 if cup_idx > 13
          if cup_idx == 6
            @cups[6] += 1 if current_player_name.name == @name1
          elsif cup_idx == 13
            @cups[13] += 1 if current_player_name.name == @name2
          else
            @cups[cup_idx] += 1
          end
          @temp_stones -= 1
      end

      render
      next_turn(cup_idx)
  end

  def next_turn(ending_cup_idx)
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx] == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup}}      \n"
    puts "#{@cups[13]} -------------------------- #{@cups[6]}"
    print "      #{@cups.take(6).map { |cup| cup}}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
      return true if @cups[7..12].sum == 0 || @cups[0..5].sum == 0  
      false
  end

  def winner
      return :draw if @cups[6] == @cups[13]
      @cups[6] > @cups[13] ? (return @name1) : (return @name2)
  end
end
