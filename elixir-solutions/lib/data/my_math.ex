#
#  Math.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 10:05 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule MyMath do
  @moduledoc """
  Mathematical computation
  """
  @doc """
  Square root of a value
  """
  def square_root_f(val) when val <= 1, do: val

  def square_root_f(val) do
    2..div(val, 2)
    |> Enum.filter(fn x -> x * x <= val end)
    |> Enum.fetch!(-1)
  end

  @doc """
  Add one to the number list
  """
  def add_list(num_list, carry) when carry == 0, do: num_list

  def add_list(num_list, carry) do
    last = Enum.fetch!(num_list, -1) + carry

    if last > 9 do
      add_list(Enum.slice(num_list, 0..-2), 1) ++ [rem(last, 10)]
    else
      add_list(Enum.slice(num_list, 0..-2), 0) ++ [last]
    end
  end

  @doc """
  Square root
  """
  def square_root(num) do
    Float.round(find_square(num, num / 2), 2)
  end

  defp find_square(num, guess) when abs(num - guess * guess) < 0.001, do: guess

  defp find_square(num, guess) do
    next_guess = (guess + num / guess) / 2
    find_square(num, next_guess)
  end

  @doc """
  Generate all subsets
  """
  def generate_subset([head | rest]) when length(rest) == 0, do: [[head]]

  def generate_subset([head | rest]) do
    _gen_subset([head | rest], 0, [head]) ++ generate_subset(rest)
  end

  defp _gen_subset(arr, idx, curr) when length(arr) == idx + 1, do: curr

  defp _gen_subset(arr, idx, curr) do
    [
      curr
      | (idx + 1)..(length(arr) - 1)
        |> Enum.map(fn i -> _gen_subset(arr, i, curr ++ [Enum.at(arr, i)]) end)
        |> Enum.reduce([], fn x, acc -> acc ++ if is_list(Enum.at(x, 0)), do: x, else: [x] end)
    ]
  end

  @doc """
  Generate subset with two or more element in increasing order
  """
  def bigger_and_bigger(arr) do
    generate_subset(arr)
    |> Enum.filter(fn each ->
      length(each) >= 2 and increasing?(each)
    end)
  end

  @doc """
  Is Increasing
  """
  def increasing?(arr) when is_list(arr) and length(arr) === 0, do: true
  def increasing?(arr) when is_list(arr), do: _increasing?(arr, Enum.at(arr, 0) - 1)

  defp _increasing?([head | rest], prev) when length(rest) == 0, do: head > prev

  defp _increasing?([head | rest], prev) do
    prev < head and _increasing?(rest, head)
  end

  @doc """

  """
  @spec largest_product_3(list(integer())) :: integer()
  def largest_product_3(arr) do
    if 2 <= arr |> Enum.filter(fn x -> x < 0 end) |> Enum.count() do
      [first, second, third | rest] = arr |> Enum.sort(fn lhs, rhs -> abs(lhs) >= abs(rhs) end)
      all_positive = [first, second, third] |> Enum.filter(fn x -> x >= 0 end)

      case all_positive |> Enum.count() do
        2 ->
          remains = all_positive |> Enum.reduce(1, fn x, acc -> x * acc end)
          [hope] = rest |> Enum.filter(fn x -> x >= 0 end)
          remains * hope

        _ ->
          first * second * third
      end
    else
      [first, second, third | _] = arr |> Enum.sort(fn lhs, rhs -> lhs >= rhs end)
      first * second * third
    end
  end

  @doc """
  Find the largest continuous subarray
  """
  @spec max_continous([integer]) :: integer
  def max_continous([head | tail]) do
    do_max_continous(tail, head, head)
  end

  @spec do_max_continous([integer], integer, integer) :: integer
  defp do_max_continous([], max, curr), do: if(max > curr, do: max, else: curr)

  defp do_max_continous([head | rest], max, curr) do
    new_curr = max(curr + head, head)
    new_max = max(new_curr, max)
    do_max_continous(rest, new_max, new_curr)
  end

  @doc """
  Fibonacci sequence
  """
  @spec fibonacci(integer) :: integer
  def fibonacci(n) when n <= 2, do: 1

  def fibonacci(n) do
    fibonacci(n - 1) + fibonacci(n - 2)
  end

  @doc """
  Count how many odd number between two numbers
  """
  @spec count_odd(integer, integer) :: integer
  def count_odd(start, ending) when start >= ending, do: 0

  def count_odd(start, ending) do
    count_odd(start, ending - 1) + rem(ending - start, 2)
  end
end
