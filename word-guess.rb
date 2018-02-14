#require 'Awesome_Print'
require 'faker'
require 'colorize'

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

class Word
  #attr_reader :random_word
  def initialize(random_word)
    @random_word = random_word
  end

  def split_word
    split_word = @random_word.split('')
    return split_word
  end

  def a_word
    return @random_word
  end
end


def compare_letter(user_letter,word,rose_pic,array_underlines)
  # check if user character exitsd in word
  word_index = []
  count_letter_existance = 0

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

  display_word = ""
  array_underlines.each do |index|
    display_word+= " #{index}"
  end

  return display_word

end

def menu()
  puts "Choose a difficulty--\n  -Easy: 5 letters or less\n -Medium: 8 letters or less\n -Hard: 9+ letters! "
  user_difficulty = gets.chomp.downcase
  difficulty_array = ["easy", "medium", "hard"]

  until difficulty_array.include?(user_difficulty)
    print "Choose Easy, Medium, or Hard: "
    user_difficulty = gets.chomp.downcase
  end

  winner = 999
  random_word = Faker::Pokemon.name.downcase

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

  # puts "\n\nGuess the word we have hinted!"
  # print "\nEnter a letter: "
  # user_letter = gets.chomp
  ## replace the array of underline in compare

  while @a_pic.rose_reader.length > 0 && winner > 0

    print "\nEnter a letter: "
    user_letter = gets.chomp.downcase
    puts ""
    while user_guesses[user_letter]!= nil || user_letter.match(/^[a-z]{1}$/) == nil
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
    winner = array_underlines.count('_')
    @a_pic.roses
    @a_pic.flower_pot
    puts array_underlines
    #end of while loop - array of roses
    if winner == 0
      puts "YOU WIN - you know your pokemon!".light_blue.on_light_green.blink
    elsif @a_pic.rose_reader.length == 0
      puts "Sorry no more attempts, you lose.".light_red.on_black
      puts "The pokemon was ".light_red.on_black + "#{random_word.upcase}!".light_red.on_black.underline
    end
  end

end

menu()
