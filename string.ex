defmodule String do

  # 8.3
  def check([]), do: true
  def check([head|tail]) when head >= ?  and head <= ?~, do: check(tail)
  def check(_), do: false

  def anagram(lst1, lst2), do: Enum.sort(lst1) == Enum.sort(lst2)

  # in iex:
  # [ 'cat' | 'dog' ]
  # ['cat',100,111,103]
  # Why does iex print ‘cat’ as a string, but ‘dog’ as individual numbers?
  # because in [head|tail] head is an element (the list 'cat')
  # while tail is expected to be a list so it actually results in
  # [[99, 97, 116], 100, 111, 103].  The first element can be
  # interpreted as a string, the outermost list (which contains
  # the sublist [99, 97, 116]) cannot.

  def doop(str), do: _doop(str, 0, 1, _len(str, 0))
  defp _doop([?-|tail], result, _, place), do: _doop(tail, result, -1, place)
  defp _doop([head|tail], result, sign, place) do
    _doop(tail, result + ((head - ?0) * round(:math.pow(10, place-1)) * sign), sign, _len(tail, 0))
  end
  defp _doop([], result, _, _), do: result
  defp _len([head|tail], c) when head in '1234567890', do: _len(tail, c+1)
  defp _len(_, c), do: c
end