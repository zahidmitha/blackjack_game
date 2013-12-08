class Deck

    SUITS = ["Hearts", "Diamonds", "Clubs", "Spades"]

    VALUES = {"Ace" => 1, "Two" => 2,"Three" => 3, "Four" => 4, "Five" => 5,"Six" => 6,"Seven" => 7,"Eight" => 8, "Nine" => 9,"Ten" => 10,"Jack" => 10,"Queen" => 10,"King"=> 10}

  def initialize
    @cards = []

    SUITS.each do |suit|
      VALUES.each do |name, value|
        @cards << Card.new(name, value, suit)
      end
    end

  end

  def shuffle!
    @cards.shuffle!
  end

  def reset
    self.initialize
  end

  def cards
    @cards
  end

  def print_cards
    @cards.each {|card| puts "#{card.name} #{card.value} #{card.suit}"}
  end

end

class Dealer

  def initialize(deck)
    @deck = deck
  end

    def deal
    @deck.cards.pop(2)
    end

   def dispense_card
      card = @deck.cards.pop
      card
   end

  def flourish
    puts @deck
  end


end

class Card

  def initialize(name, value, suit)
    @name = name
    @value = value
    @suit = suit
  end

  def value
    @value
  end

def pretty_name
  "#{@name} of #{@suit} (value #{@value})"
  end

end

class Player

  attr_reader :card_total, :name

  def initialize(dealer)
    @hand = []
    @name
    @dealer = dealer
    @card_total = 0

  end

  def get_first_hand
    @hand = @dealer.deal
    print_hand
  end

  def get_next_card
    @hand << @dealer.dispense_card
    print_hand
  end

  def get_name
    puts "What is your name?"
    name = gets.chomp
    @name = name
    @name
  end

  def print_hand
    card_pretty_names = []
    @hand.each do |card|
      card_pretty_names << card.pretty_name
      @card_total += card.value
    end
    puts "#{@name}: My hand is the #{card_pretty_names.join(" and the ")}"
    puts "My total is #{@card_total}"
  end

  def pick_card
    puts "Hit or stick?"
    answer = gets.chomp
    if answer == "hit"
      get_next_card
      pick_card
    elsif answer == "stick"
      print_hand
    else
      puts "I didn't understand that"
    end
  end

end

class Opponent
  attr_reader :card_total, :name

  def initialize(dealer)
    @hand = []
    @name
    @dealer = dealer
    @card_total = 0

  end

  def get_first_hand
    @hand = @dealer.deal
  end

  def get_next_card
    @hand << @dealer.dispense_card
  end

  def get_name
    puts "What is your opponent's name?"
    name = gets.chomp
    @name = name
    @name
  end

  def print_hand
    card_pretty_names = []
    @hand.each do |card|
      card_pretty_names << card.pretty_name
      @card_total += card.value
    end
    puts "#{@name}: My hand is the #{card_pretty_names.join(" and the ")}"
    puts "My total is #{@card_total}. I'm sticking...bitch."
  end

  def artificial_intelligence
    if @card_total >= 15
      @card_total
      print_hand
    elsif @card_total < 15
      get_next_card
    end
  end

end

class Rules

  def initialize(player,deck,dealer,opponent)
    @player = player
    @deck = deck
    @dealer = dealer
    @opponent = opponent
  end

  def bust
    if @player.card_total > 21
      puts "BUST"
      exit
    else @player.card_total < 21
      @player.pick_card
    end
  end

  def winner
    if @player.card_total >= @opponent.card_total
      puts "#{@player.name} wins!"
      exit
    elsif @opponent.card_total > @player.card_total
      puts "#{@opponent.name}"
    end
  end

end


# card = Card.new
deck = Deck.new
deck.shuffle!
dealer= Dealer.new(deck)
player = Player.new(dealer)
opponent = Opponent.new(dealer)
player.get_name
opponent.get_name
player.get_first_hand
player.pick_card
opponent.get_first_hand
opponent.artificial_intelligence
rules = Rules.new(player, deck, dealer, opponent)
rules.bust
rules.winner