# 6.4
defmodule Chop do

  def guess(target, s..e) do
    guess_it(target, [s..e], midway(s, e))
  end

  def guess_it(target, [s..e], current) when target == current do
    IO.puts "is it #{current}"
    IO.puts "it is!"
    current
  end

  def guess_it(target, [s..e], current) when target < current do
    IO.puts "is it #{current}"
    guess_it(target, [s..current-1], midway(s, current-1))
  end

  def guess_it(target, [s..e], current) when target > current do
    IO.puts "is it #{current}"
    guess_it(target, [current+1..e], midway(current+1, e))
  end

  def midway(s, e) do
    div((e - s), 2) + s
  end
end