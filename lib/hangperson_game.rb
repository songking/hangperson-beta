class HangpersonGame
attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses, :check_win_or_lose

  def initialize(new_word)
  	@word = new_word
  	@guesses = ''
  	@wrong_guesses = ''
  	@check_win_or_lose = :play
  	@word_with_guesses = ''
  	for i in 0...new_word.length
  		@word_with_guesses += '-'
  	end
  end

  def guess(letter)
  	if not letter =~ /[[:alpha:]]/
  		raise ArgumentError, "Invalid input. Input needs to be a letter." 
  	elsif self.guesses.include? letter or self.wrong_guesses.include? letter
  		false
  	elsif self.word.include? letter
  		self.guesses += letter
  		update_word_with_guesses(letter)
  		true
	else
		self.wrong_guesses += letter
		true
	end
  end

  def update_word_with_guesses(letter)
  	for i in 0...self.word.length
  		if self.word[i] == letter
  			self.word_with_guesses[i] = letter
  		end
  	end
  end

  def check_win_or_lose
  	if !self.word_with_guesses.include? '-'
  		self.check_win_or_lose = :win
  	elsif self.wrong_guesses.length >= 7
  		self.check_win_or_lose = :lose
  	else
  		self.check_win_or_lose = :play
  	end
  end

  # Get a word from remote "random word" service
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
end