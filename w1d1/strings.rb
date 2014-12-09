def num_to_s(num, base)
  hex_base = %w{ 0 1 2 3 4 5 6 7 8 9 A B C D E F }
  result = []
  n = num
  while n > 0
    div, mod = n.divmod(base)
    result << hex_base[mod]
    n = div
  end
  result.reverse.join
end

def caesar_cipher(str, shift)
  from = ('a'..'z').to_a.join
  to = ('a'..'z').to_a.rotate(shift).join
  str.tr(from, to)
end
