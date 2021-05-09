#
#  Array.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 7:23 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Array do
  @moduledoc """
  Array manipulation
  """

  @doc """
  Get the only unique element in a list
  """
  def one_value(list) when is_list(list) do
    list
    |> Enum.filter(fn x -> Enum.count(list, fn y -> y == x end) == 1 end)
    |> Enum.fetch!(0)
  end

  @doc """
  Rotate a one dimensional array
  """
  def rotate_1d([head | rest], count) when count == 0, do: [head] ++ rest

  def rotate_1d([head | rest], count) do
    rotate_1d(rest ++ [head], count - 1)
  end

  @doc """
  Find the min subarray that is bigger or equal
  """
  def min_subarray(list, s) when is_list(list) do
    0..(length(list) - 1)
    |> Enum.filter(fn r -> min_subs(list, 0, r, s) end)
    |> Enum.map(fn r -> r + 1 end)
    |> Enum.min()
  end

  defp min_subs(list, at, count, _s) when is_list(list) and at + count >= length(list), do: false

  defp min_subs(list, at, count, s) when is_list(list) do
    curr =
      list
      |> Enum.slice(at..(at + count))
      |> Enum.sum()

    if curr >= s, do: true, else: min_subs(list, at + 1, count, s)
  end

  @doc """
  Equal share, given a positive integer determine whether the array can be partition with equal sums
  """
  def equal_share?(list) do
    #    _equalize?(list, 0)
    _optimized_eq?(list, 0, 0, Enum.sum(list))
  end

  defp _optimized_eq?(list, index, lhs, rhs) when length(list) == index, do: lhs == rhs

  defp _optimized_eq?(list, index, lhs, rhs) do
    curr = Enum.at(list, index)

    cond do
      lhs + curr == rhs - curr -> true
      true -> false or _optimized_eq?(list, index + 1, lhs + curr, rhs - curr)
    end
  end

  @doc """
  Max increasing subsequence
  O(n) time, and O(n) space (given the recursive stack consist of prev, curr, best: integer. No mutation)
  """
  def max_increasing(arr) do
    _max_increasing(arr, Enum.at(arr, 0) - 1, 0, 0)
  end

  defp _max_increasing([head | rest], prev, curr, best) when length(rest) == 0 do
    cond do
      head > prev -> if best > curr + 1, do: best, else: curr + 1
      true -> if best > curr, do: best, else: curr
    end
  end

  defp _max_increasing([head | rest], prev, curr, best) do
    cond do
      head > prev ->
        _max_increasing(rest, head, curr + 1, best)

      true ->
        next_max = if best > curr, do: best, else: curr
        _max_increasing(rest, head, 1, next_max)
    end
  end

  #  defp _equalize?(list, index) when length(list) == index, do: false
  #  defp _equalize?(list, index) do
  #    sum_first = Enum.sum(Enum.slice(list, 0..index))
  #    sum_rest = Enum.sum(Enum.slice(list, index + 1..-1))
  #    cond do
  #      sum_first == sum_rest -> true
  #      true -> false or _equalize?(list, index + 1)
  #    end
  #  end

  @doc """
  Two sum: return two values summed to target
  """
  @spec two_sum(list(integer()), integer()) :: {integer(), integer()}
  def two_sum(arr, target) do
    case _two_sum(arr, target, MapSet.new()) do
      {:ok, {lhs, rhs}} -> {lhs, rhs}
      :error -> {-1, -1}
    end
  end

  @spec _two_sum(list(integer()), integer(), MapSet.t()) :: {:ok, {integer(), integer()}} | :error
  defp _two_sum(arr, _target, _set) when length(arr) == 0, do: :error

  defp _two_sum([head | rest], target, set) do
    remains = target - head

    case set |> MapSet.member?(remains) do
      true -> {:ok, {head, remains}}
      false -> _two_sum(rest, target, set |> MapSet.put(head))
    end
  end

  @doc """
  Three sum: return three values summed to target
  """
  @spec three_sum(list(integer()), integer()) :: {integer(), integer(), integer()}
  def three_sum(arr, target) do
    case _three_sum(arr, target) do
      {:ok, res} -> res
      :error -> {-1, -1, -1}
    end
  end

  defp _three_sum(arr, _target) when length(arr) == 0, do: :error

  defp _three_sum([first | rest], target) do
    case _two_sum(rest, target - first, MapSet.new()) do
      {:ok, {lhs, rhs}} -> {:ok, {first, lhs, rhs}}
      :error -> _three_sum(rest, target)
    end
  end

  @doc """
  Scan
  """
  @spec sum_scan(list(number())) :: list(number())
  def sum_scan(arr) do
    arr
    |> Enum.scan(&+/2)
  end

  @doc """
  Find intersection of three sorted list
  """
  @spec intersection_sorted([integer], [integer], [integer]) :: [integer]
  def intersection_sorted(nums1, nums2, nums3)
      when length(nums1) == 0 or length(nums2) == 0 or length(nums3) == 0,
      do: []

  def intersection_sorted([h1 | r1], [h2 | r2], [h3 | r3]) do
    min_val = Enum.min([h1, h2, h3])

    cond do
      min_val == h1 and min_val == h2 and min_val == h3 ->
        [h1] ++ intersection_sorted(r1, r2, r3)

      true ->
        intersection_sorted(
          if(min_val == h1, do: [h1 | r1], else: r1),
          if(min_val == h2, do: [h2 | r2], else: r2),
          if(min_val == h3, do: [h3 | r3], else: r3)
        )
    end
  end
end
