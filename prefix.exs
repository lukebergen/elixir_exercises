# 5.3

prefix = fn (prefix) -> fn (suffix) -> "#{prefix} #{suffix}" end end
mrs = prefix.("Mrs")
mrs.("Smith")
prefix.("Elixir").("Rocks")
