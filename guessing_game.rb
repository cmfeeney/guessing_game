def num_compare(a,b)
  if a > b
    puts 'Your guess is too high.'
  elsif a < b
    puts 'Your guess is too low.'
  end
end

def tries_rem(word)
  if word == 1
    puts 'You have one try left.'
  else
    puts "You have #{word} tries left."
  end
end

def add_leaderboard(user, score, board)
  board[user] = score
end

def display_leaderboard(board)
  if board.count >= 1
    puts "Leaderboard with number of guesses: "
    board = board.sort_by { |name, score| score}.to_h
    puts board
  else
    puts "Nobody has won the game yet!"
  end
  puts "Would you like to play again? Y/N"
  again = gets.chomp
  if again.downcase[0] == "y"
    new_game((0..100).to_a.sample,10,board)
  else
    exit
  end
end

def new_game(comp,tries,leaderboard)
  puts "Welcome to the Number Guessing Game! What is your name?"
  name = gets.chomp
  puts "Try and guess the computer's number 1-100. You get #{tries} tries."
  puts "The computer's random number is #{comp}."
  count = 0
  play_game(count,comp,tries,leaderboard,name)
end

def play_game(count,comp,tries,leaderboard,name)
  guesses = []
  while count < tries do
    puts 'Enter your guess: '
    guess = gets.chomp
    answer = guess.to_i
    high_ans = guesses.select do |x| x > comp end
    low_ans = guesses.select do |x| x < comp end
      if guesses.include?(answer)
        puts 'Are you feeling ok? You already guessed that number!'
      elsif count >= 1 and answer > comp and high_ans.count >= 1 and answer > high_ans.sort![0]
        puts "That guess doesn't help you. I already told you the number is lower than #{high_ans.sort![0]}."
      elsif count >= 1 and answer < comp and low_ans.count >= 1 and answer < low_ans.sort!.last
        puts "Wasted guess! I already told you the number is higher than #{low_ans.sort!.last}."
      end
      guesses << answer
      if answer != comp and count + 1 == tries
        num_compare(answer, comp)
        puts "Sorry, you lost! The computer's number was #{comp}."
        display_leaderboard(leaderboard)
        count = 0
      elsif answer != comp
        count += 1
        count_diff = tries - count
        num_compare(answer, comp)
        tries_rem(count_diff)
      else
        count += 1
        num_compare(answer, comp)
        puts 'Correct, you win!'
        add_leaderboard(name, count, leaderboard)
        display_leaderboard(leaderboard)
      end
    end
end

leaderboard = {}
player_count = 0
tries = 10
comp = (0..100).to_a.sample

new_game(comp,tries,leaderboard)
