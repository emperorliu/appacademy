def super_print(str, opts = {})
  defaults = {:times => 1, :upcase => false, :reverse => false}
  opts = defaults.merge(opts)

  str = str.upcase if opts[:upcase]
  str = str.reverse if opts[:reverse]
  opts[:times].times { puts str }

  nil
end
