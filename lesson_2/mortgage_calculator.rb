# take loan amount
# take the APR (annual percentage rate)
# take loan duration

# calculate monthly interest rate
# calculate loan duration in months
# calculate monthly payment

# m = monthly payment
# p = loan amount
# j = monthly interest rate
# n = loan duration in months

# formula to calculate monthly payments: m = p * (j / (1 - (1 + j)**(-n)))

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_integer?(num)
  num.to_i() != 0 && num.to_i().positive?()
end

def valid_months?(num)
  num.to_i() < 12
end

def valid_loan?(num)
  num.to_i() < 1000000
end

def valid_float?(num)
  num.to_f().to_s() == num
end

prompt("Hello and welcome to the mortgage calculator!")

name = ''
loop do
  prompt("Please enter your name:")
  name = Kernel.gets().chomp()
  if name.empty?()
    puts "You must enter your name!"
  else
    break
  end
end

prompt("Hi #{name}!")
prompt("I just need a few more details...")

loan_amount = ''
loop do
  prompt("How much are you borrowing?(£)")
  prompt("Please enter a number between 1-999999")
  loan_amount = Kernel.gets().chomp().to_i()
  if valid_integer?(loan_amount) || valid_loan?(loan_amount)
    break
  else
    prompt("You must enter a valid whole number between 1-999999")
  end
end

apr = ''
loop do
  prompt("Please enter the expected APR (Annual Percentage Rate)")
  apr = Kernel.gets().chomp()
  if valid_float?(apr) || valid_integer?(apr)
    break
  else
    prompt("You must enter a valid value!")
  end
end

loan_duration_years = ''
loop do
  prompt("Please enter the loan duration (years)")
  loan_duration_years = Kernel.gets().chomp()
  if valid_integer?(loan_duration_years)
    break
  else
    prompt("You must enter a valid number of years")
  end
end

loan_duration_months = ''
loop do
  prompt("And how many months?")
  loan_duration_months = Kernel.gets().chomp()
  if valid_integer?(loan_duration_months) || valid_months?(loan_duration_months)
    break
  else
    prompt("You must enter a valid number of months!")
  end
end

monthly_interest_rate = (apr.to_f() / 100) / 12

loan_duration_total = (loan_duration_years.to_i() * 12) +
                      loan_duration_months.to_i()

monthly_payment = loan_amount * (monthly_interest_rate /
                  (1 - (1 + monthly_interest_rate)**(-loan_duration_total)))

prompt("Your monthly payment will be £#{monthly_payment.round(2)}.")
