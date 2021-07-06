VALID_CHOICES = ['rock', 'paper', 'scissors', 'spock', 'lizard']
VALID_ANSWERS = ['r', 'p', 'sc', 'sp', 'l']
player_score = {
  player: 0,
  computer: 0
}

def clear
  system('clear')
end

def prompt(message)
  Kernel.puts(">> #{message}")
end

def win?(first, second)
  (['paper', 'p'].include?(first) && ['rock', 'r', 'spock', 'sp'].include?(second)) ||
    (['scissors', 's'].include?(first) && ['paper', 'p', 'lizard', 'l'].include?(second)) ||
    (['rock', 'r'].include?(first) && ['scissors', 's', 'lizard', 'l'].include?(second)) ||
    (['lizard', 'l'].include?(first) && ['paper', 'p', 'spock', 'sp'].include?(second)) ||
    (['spock', 'sp'].include?(first) && ['rock', 'r', 'scissors', 'sc'].include?(second))
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def shortform?(x)
  x == ['y', 'r', 'sc', 'sp', 'l'].sample
end

def full_choice(x)
  case x
  when 'p' then 'paper'
  when 'r' then 'rock'
  when 'sc' then 'scissors'
  when 'sp' then 'spock'
  when 'l' then 'lizard'
  end
end

def points_tally(player, computer, player_score)
  if win?(player, computer)
    player_score[:player] += 1
  elsif win?(computer, player)
    player_score[:computer] += 1
  end
end

clear()
prompt("Welcome to rock, paper, scissors, lizard, spock!")
prompt("You need 3 points to win, good luck!")
loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    prompt("You may type the shortform (#{VALID_ANSWERS.join(', ')})")
    choice = Kernel.gets().chomp()
    clear()

    if VALID_CHOICES.include?(choice) || VALID_ANSWERS.include?(choice)
      break
    else
      prompt("That's not a valid choice")
    end
  end

  if shortform?(choice)
    updated_player_choice = full_choice(choice)
  else
    updated_player_choice = choice
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{updated_player_choice}; Computer chose: #{computer_choice}")

  display_result(updated_player_choice, computer_choice)

  points_tally(updated_player_choice, computer_choice, player_score)

  prompt("Current Score: #{player_score}")
  prompt("")
  prompt("")

  if player_score[:computer] == 3
    clear()
    prompt(player_score)
    prompt("Computer wins!")
    break
  elsif player_score[:player] == 3
    clear()
    prompt(player_score)
    prompt("You win!")
    break
  end
end

prompt("Thank you for playing, goodbye!")
