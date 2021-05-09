require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

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
  num.to_i() < 12 && num.to_i() >= 0
end

def valid_loan?(num)
  num.to_i() < 1000000
end

def valid_float?(num)
  num.to_f().to_s() == num && num.to_f().positive?()
end

prompt(MESSAGES['welcome'])

name = ''
prompt(MESSAGES['name'])
loop do
  name = Kernel.gets().chomp()
  if name.empty?()
    prompt(MESSAGES['name_insist'])
  else
    break
  end
end

prompt("Hi #{name}!")

loop do
  prompt(MESSAGES['details'])
  prompt(MESSAGES['borrowing'])
  prompt(MESSAGES['loan_amount'])
  loan_amount = ''
  loop do
    loan_amount = Kernel.gets().chomp().to_i()
    if valid_integer?(loan_amount) && valid_loan?(loan_amount)
      break
    else
      prompt(MESSAGES['loan_amount_insist'])
    end
  end

  apr = ''
  prompt(MESSAGES['apr'])
  loop do
    apr = Kernel.gets().chomp()
    if valid_float?(apr) || valid_integer?(apr)
      break
    else
      prompt(MESSAGES['apr_insist'])
    end
  end

  loan_duration_years = ''
  prompt(MESSAGES['loan_duration_years'])
  loop do
    loan_duration_years = Kernel.gets().chomp()
    if valid_integer?(loan_duration_years)
      break
    else
      prompt(MESSAGES['loan_duration_years_insist'])
    end
  end

  loan_duration_months = ''
  loop do
    prompt(MESSAGES['loan_duration_months'])
    loan_duration_months = Kernel.gets().chomp()
    if valid_months?(loan_duration_months)
      break
    else
      prompt(MESSAGES['loan_duration_months_insist'])
    end
  end

  monthly_interest_rate = (apr.to_f() / 100) / 12

  loan_duration_total = (loan_duration_years.to_i() * 12) +
                        loan_duration_months.to_i()

  monthly_payment = loan_amount * (monthly_interest_rate /
                    (1 - (1 + monthly_interest_rate)**(-loan_duration_total)))

  prompt("Your monthly payment will be £#{monthly_payment.round(2)}.")

  prompt(MESSAGES['again'])
  another_calculation = Kernel.gets().chomp()
  break unless another_calculation.downcase.start_with?('y')
end
prompt(MESSAGES['goodbye'])
