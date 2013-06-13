# 7.5 - 7.7
defmodule MyList do
  # 7.5
  def map_sum(lst, func), do: _map_sum(lst, 0, func)
  defp _map_sum([], total, _func), do: total
  defp _map_sum([head|tail], total, func), do: _map_sum(tail, total + func.(head), func)

  def max(lst), do: _max(lst, 0)
  defp _max([], best), do: best
  defp _max([head|tail], best) when head > best, do: _max(tail, head)
  defp _max([head|tail], best) when head <= best, do: _max(tail, best)

  def caesar(str, n), do: _caesar(str, n, '')
  defp _caesar('', _, result), do: _reverse(result)
  defp _caesar([head|tail], n, result), do: _caesar(tail, n, [_caes(head, n)|result])
  defp _caes(c, n) when c + n > 122, do: c + n - 26
  defp _caes(c, n) when c + n <= 122, do: c + n

  defp _reverse(l), do: _reverse(l, [])
  defp _reverse([], r), do: r
  defp _reverse([head|tail], r), do: _reverse(tail, [head|r])

  # 7.6
  def flatten(lst), do: Enum.reverse(_flatten(lst, []))
  defp _flatten([head|tail], r) when is_list(head), do: _flatten(tail, _flatten(head, r))
  defp _flatten([], r), do: r
  defp _flatten([head|tail], r), do: _flatten(tail, [head|r])

  # 7.7
  def all?(lst), do: _all?(lst, fn(x) -> x end)
  defp _all?([], _), do: true
  defp _all?([head|tail], fun), do: _all_check(fun.(head), tail, fun)
  defp _all_check(r, _, _) when !r, do: false
  defp _all_check(_, lst, fun), do: _all?(lst, fun)

  def each([], _), do: :ok
  def each([head|tail], fun) do
    fun.(head)
    each(tail, fun)
  end

  def filter(lst, fun), do: Enum.reverse(_filter(lst, fun, []))
  defp _filter([], _, r), do: r
  defp _filter([head|tail], fun, r), do: _check_filter(head, tail, fun, r, fun.(head))
  defp _check_filter(head, lst, fun, r, true), do: _filter(lst, fun, [head|r])
  defp _check_filter(_, lst, fun, r, false), do: _filter(lst, fun, r)

  def span(lst, from, to), do: Enum.reverse(_span(lst, from, to, 0, []))
  defp _span(lst, from, to, current, _) when current < from do
    _span(lst, from, to, current + 1, [])
  end
  defp _span([head|tail], from, to, current, r) when current < to do
    _span(tail, from, to, current + 1, [head|r])
  end
  defp _span(_, _, to, current, r) when current >= to, do: r

  # the book suggests using span to help with primes...
  # I can't figure out a solution that uses span
  def primes(n), do: Enum.reverse(_primes(n, 2, []))
  defp _primes(n, current, primes) when current > n, do: primes
  defp _primes(n, current, primes) do
    prime_factors = lc x inlist primes, rem(current, x) == 0, do: x
    _primes(n, current + 1, _add_prime(current, primes, prime_factors))
  end
  defp _add_prime(n, primes, []), do: [n|primes]
  defp _add_prime(_, primes, _), do: primes

  def tax_it(rates, orders) do
    lc {state_rate,tax_rates} inlist rates, [{_,id}, {_,ship_to}, {_,cost}] inlist orders, 
      state_rate == ship_to || !(ship_to in _extract_states(rates)) do
      # state_rate == ship_to || !(ship_to in [:NC, :TX]) do
        [id: id, ship_to: ship_to, net_amount: cost, total_amount: cost + (cost * tax_rates)]
    end
  end
  defp _extract_states(rates) do
    Enum.map rates, fn ({state, _}) -> state end
  end
end

# data for tax_it test:
# tax_rates = [ NC: 0.075, TX: 0.08 ]
# orders = [
# [ id: 123, ship_to: :NC, net_amount: 100.00 ],
# [ id: 124, ship_to: :OK, net_amount: 35.50 ],
# [ id: 125, ship_to: :TX, net_amount: 24.00 ],
# [ id: 126, ship_to: :TX, net_amount: 44.80 ],
# [ id: 127, ship_to: :NC, net_amount: 25.00 ],
# [ id: 128, ship_to: :MA, net_amount: 10.00 ],
# [ id: 129, ship_to: :CA, net_amount: 102.00 ],
# [ id: 120, ship_to: :NC, net_amount: 50.00 ] ]