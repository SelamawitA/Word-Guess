require 'faker'
require 'colorize'

# Creates a flower pot object that can delete a rose, print the pot/stem, return rose arrays, and display roses to the user.
class Picture ()
  def initialize ()
    @picture = '
    ,\,\,|,/,/, '.light_green +
    '
       _\|/_
      |_____|
       |   |
       |___|

'
@array_roses = ['(@)','(@)','(@)','(@)','(@)','(@)']
end
#prints roses
def roses
  @array_roses.each do |rose|
    print rose.light_red
  end
end
#deletes a single rose
def delete
  @array_roses.pop
end
#prints flower pot
def flower_pot
  print @picture
end
#returns rose array
def rose_reader
  return @array_roses
end

end

# Creates a word object that can be returned to the user or split in an array of characters.
class Word
  #attr_reader :random_word
  def initialize(random_word)
    @random_word = random_word
  end

  # Splits word in an array of characters.
  def split_word
    split_word = @random_word.split('')
    return split_word
  end

  # Returns word to the user.
  def a_word
    return @random_word
  end
end

# Method compares user input to random word and returns an updated string of underscores to reflect a correct answer.
def compare_letter(user_letter,word,rose_pic,array_underlines)
  word_index = []
  count_letter_existance = 0
  # searches user's input letter in word and uses index to update underscore array or update counter.
  word.split_word.each_with_index{|letter,index|
    if user_letter == letter
      array_underlines[index] = user_letter
    elsif !word.split_word.include?(user_letter)
      count_letter_existance+=1
    end

    if count_letter_existance == word.split_word.length
      puts "Wrong guess!"
      rose_pic.delete
    end
  }

  # Updates array of underscores.
  display_word = ""
  array_underlines.each do |index|
    display_word+= " #{index}"
  end

  return display_word

end

def menu()
  winner = 999
  random_word = Faker::Pokemon.name.downcase
  # Welcome message to the user
  puts "Hello! Welcome to the Pokemon Word Guessing Game!\n\n"
  puts "Choose a difficulty--\n -Easy: 5 letters or less\n -Medium: 8 letters or less\n -Hard: 9+ letters! "
  print "\nMenu choice: "
  user_difficulty = gets.chomp.downcase
  difficulty_array = ["easy", "medium", "hard"]

  # User selects menu option
  until difficulty_array.include?(user_difficulty)
    print "Choose Easy, Medium, or Hard: "
    user_difficulty = gets.chomp.downcase
  end

  if user_difficulty == "easy"
    until random_word.length <= 5
      random_word = Faker::Pokemon.name.downcase
    end
  elsif user_difficulty == "medium"
    until random_word.length <= 8 && random_word.length > 5
      random_word = Faker::Pokemon.name.downcase
    end
  elsif user_difficulty == "hard"
    until random_word.length > 8
      random_word = Faker::Pokemon.name.downcase
    end
  end

  rand_word = Word.new(random_word)
  @a_pic = Picture.new()
  @a_pic.roses
  @a_pic.flower_pot
  user_guesses = {}
  blank_array = []
  rand_word.split_word.length.times do
    blank_array << "_"
  end
  blank_array.each do |i|
    print " #{i}"
  end

  while @a_pic.rose_reader.length > 0 && winner > 0
    print "\n\nEnter a letter: "
    user_letter = gets.chomp.downcase
    # Validates user input.
    while user_guesses[user_letter]!= nil || user_letter.match(/^[a-z]{1}$/) == nil #|| user_letter == "solve"
      if user_guesses[user_letter] != nil
        puts "You've already guessed that! Guess again."
        user_letter = gets.chomp.downcase
      elsif user_letter.match(/^[a-z]{1}$/) == nil
        puts "Enter a single letter guess."
        user_letter = gets.chomp.downcase
      end
    end
    user_guesses[user_letter] = 'a_guess'
    array_underlines = compare_letter(user_letter,rand_word,@a_pic,blank_array)
    #winner = array_underlines.count('_')
    @a_pic.roses
    @a_pic.flower_pot
    puts array_underlines
    #end of while loop - array of roses
    if winner == 0 #|| solved
      puts "YOU WIN - you know your pokemon!".light_blue.on_light_green.blink
    elsif @a_pic.rose_reader.length == 0 #|| !solved
      puts "Sorry no more attempts, you lose.".light_red.on_black
      puts "The pokemon was ".light_red.on_black + "#{random_word.upcase}!".light_red.on_black.underline
    end
  end

end

# Attempted to allow the user to input the entire word ##
# def guess_the_word(random_word)
#   puts "Guess the Pokemon! "
#   user_guess = gets.chomp.downcase
#   if user_guess == random_word
#     solve_value = true
#   elsif user_guess != random_word
#     solve_value = false
#   end
# end

menu()
