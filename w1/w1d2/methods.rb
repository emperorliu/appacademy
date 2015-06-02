def outcome(str, comp)
  condition = [str.downcase, comp]
  pairs = [["rock", "scissors"], ["scissors", "paper"], ["paper", "rock"]]
  if pairs.include?(condition)
    "Win"
  elsif pairs.include?(condition.reverse)
    "Lose"
  else
    "Draw"
  end
end

def rps(str)
  rps_choices = ["rock", "paper", "scissors"]
  comp_choice = rps_choices.sample

  "#{comp_choice.capitalize}, #{outcome(str, comp_choice)}"
end


def remix(arr)
  alcohols = arr.map(&:first)
  mixers = arr.map(&:last)
  mixers.shuffle! while arr & alcohols.zip(mixers) != []

  alcohols.zip(mixers)
end

# shorter implementation
def remix(arr)
  alcohols, mixers = arr.transpose
  mixers.shuffle! while arr & alcohols.zip(mixers) != []
  alcohols.zip(mixers)
end
