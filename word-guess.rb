class Word

  def initialize (letter,word)
    @letter = letter
    @word = word
  end

  def compare_letter
    # check if user character exits in word
    # if word.split().include? letter
      value = 0
      @word.split('').each do |i|
        if i == @letter
          value = @word.split('').index(i)
        end
      end
      return value
  end

#end of class
end

#
# testr = Word.new('r','afraid')
# print testr.compare_letter



def menu()
random_words = ['cat','dog', 'bird']
rand_word = random_words.sample
rand_word.split('')
  blank_array = []
rand_word.split('').length.times do
  blank_array << "_"
end
puts rand_word
puts blank_array
end

# print "Enter a letter "
# user_letter = gets.chomp

menu
