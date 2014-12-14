# operators = %w( + - / * )
#
# $stdin.each do |line|
#   operators.each do |op|
#     if line.include?(op)
#       a, b = line.gsub(" ", "").split(/\D/)
#       p [a.to_i,b.to_i].inject(&op.to_sym)
#     else
#       break
#     end
#   end
#   break
# end

class RPNCalculator
  def initialize
    @stack = []
  end

  def push(num)
    @stack << num

    self
  end

  def perform_op(op_sym)
    raise RuntimeError.new("Too few operands!") unless @stack.count >= 2

    right_operand = @stack.pop
    left_operand = @stack.pop

    case op_sym
    when :+
      @stack << left_operand + right_operand
    when :-
      @stack << left_operand - right_operand
    when :*
      @stack << left_operand * right_operand
    when :/
      # `Fixnum#fdiv` is like `/` but makes sure not to round down.
      @stack << left_operand.fdiv(right_operand)
    else
      @stack << left_op << right_op
      raise ArgumentError.new("No operation #{op_sym}")
    end

    self
  end

  def extract_value
    case @stack.count
    when 0
      raise RuntimeError.new("There are still no operands in the stack.")
    when 1
      @stack.pop
    else
      raise RuntimeError.new("There are still #{@stack.count} operands left.")
    end
  end

  def self.evaluate_file(file)
    calc = RPNCalculator.new
    ops = ["+", "-", "*", "/"]

    file.each do |line|
      line = line.chomp

      if ops.include?(line)
        calc.perform_op(line.to_sym)
      elsif line =~ /\A[0-9]+\z/
        calc.push(line.to_i)
      else
        # Break out of loop as $stdin goes on forever.
        # This lets us quit by submitting any invalid character.
        break
      end
    end

    calc.extract_value
  end
end

if __FILE__ == $PROGRAM_NAME
  # only run this in program mode
  if ARGV.empty?
    # if no file given, read input from the standard input (console)
    # file
    puts RPNCalculator.evaluate_file($stdin)
  else
    File.open(ARGV[0]) do |file|
      puts RPNCalculator.evaluate_file(file)
    end
  end
end
