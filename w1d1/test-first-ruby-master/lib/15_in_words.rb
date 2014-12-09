ONE_TO_NINETEEN = %w(zero one two three four five six seven eight nine ten
                     eleven twelve thirteen fourteen fifteen sixteen
                     seventeen eighteen nineteen)

TENS = %w(twenty thirty forty fifty sixty seventy eighty ninety)
MAGNITUDES = { 100 => "",
               1000 => "thousand",
               1_000_000 => "million",
               1_000_000_000 => "billion",
               1_000_000_000_000 => "trillion" }

class Fixnum

  def in_words
    if self < 20
      ONE_TO_NINETEEN[self]
    elsif self < 100
      a, b = self.divmod(10)
      "#{TENS[a - 2]}" + (b == 0 ? "" : " #{ONE_TO_NINETEEN[b]}")
    elsif self < 1000
      a, b = self.divmod(100)
      "#{ONE_TO_NINETEEN[a]} hundred" + (b == 0 ? "" : " " + b.in_words)
    else
      mgtds = MAGNITUDES.select { |k, v| k <= self}.values.reverse
      arr = to_s.split(//).map(&:to_i)
      triples = []
      while arr.length >= 3
        popped = arr.pop(3).join.to_i
        if popped == 0
          triples.unshift("")
        else
          triples.unshift(popped.in_words)
        end
      end
      triples.unshift(arr.join.to_i.in_words) if arr.any?
      triples.zip(mgtds).select { |i, j| i != "" }.flatten.join(" ").squeeze(" ").strip
    end
  end
end
