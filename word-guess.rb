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
       |___| '
     
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

#  ap word.split_word

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
  #e
  display_word = ""
  array_underlines.each do |index|
    display_word+= " #{index}"
  end

  return display_word




  #### FIRST DRAFT of Compare_letter Function! #####
  # if word.split_word.include? letter
  #   value = word.split_word.index(letter)
  # else
  #    value = false #& do something to pic
  #    rose_pic.delete
  #    #rose_pic.roses
  #    #rose_pic.flower_pot
  #    end
  #  return value
end

def menu()
  winner = 999
  # random_words = ['jazzed','dogged', 'puzzle', 'muzzle']
  rand_word = Word.new(Faker::Pokemon.name.downcase)
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
    puts "#{rand_word.a_word}"
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
      puts "Sorry no more attempts, you lose!".light_red.on_black
    end
  end

end

menu()
