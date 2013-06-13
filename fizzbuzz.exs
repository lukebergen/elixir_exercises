# 5.2
fb = fn
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, x) -> x
end

fizz_buzz = fn (n) -> fb.(rem(n, 3), rem(n, 5), n) end

fizz_buzz.(10)
fizz_buzz.(11)
fizz_buzz.(12)
fizz_buzz.(13)
fizz_buzz.(14)
fizz_buzz.(15)
fizz_buzz.(16)
