class CoffeeError < StandardError
  # def initialize(msg="That is not a fruit! But I love coffee so you can try again :)")
  #   super
  # end
end


# PHASE 2
def convert_to_int(str)
  begin
    Integer(str)
  rescue ArgumentError
    raise "Not an integer!"
  end
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeError 
  else
    raise StandardError 
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  begin
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue CoffeeError
    puts "That is not a fruit! But I love coffee so you can try again :)"
    retry
  rescue StandardError
    puts "No second chances, I wanted fruit!"
  end
end  

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime

    raise "I need to know your name!" if @name.length <= 0
    raise "We are just aquaintences until we have been buds for five years" if @yrs_known < 5
    raise "But what is your favorite pastime??" if @fav_pastime.length <= 0
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


