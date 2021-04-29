#
#  Limit.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 11:24 AM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Limit do
  @moduledoc """
  Module for question with constrains
  """

  defmacro return(x), do: x

  @doc """
  Min operation of *2 | -1
  """
  @spec min_operation(integer(), integer()) :: integer()
  def min_operation(start, target) when start == target, do: 0
  def min_operation(start, target) do
    # Two operations allowed * 2, and - 1
    cond do
      start > target -> 1 + min_operation(start - 1, target)
      target - start >= start -> 1 + min_operation(start * 2, target)
      true ->
        upper = min_operation(start * 2, target)
        lower = min_operation(start - 1, target)
        1 + if upper < lower, do: upper, else: lower
    end
  end

  @type miss_n_dup
        :: %{missing: integer(), duplicate: integer()}

  @doc """
  Find missing and duplicates, 1 duplicate, and 1 missing
  """
  @spec missing_dup(list(integer())) :: miss_n_dup()
  def missing_dup(arr) do
    n = length(arr)
    dup = Kth.find_one_dup(arr)
    %{missing: dup + div(n * (n + 1), 2) - Enum.sum(arr), duplicate: dup}
  end

  @doc """
  Give all missing bounds not in nums, from lower to upper
  """
  @spec missing_bounds(list(integer()), integer(), integer()) :: list(String.t())
  def missing_bounds(nums, lower, upper) when length(nums) <= 0 do
    cond do
      upper < lower -> []
      upper == lower -> ["#{upper}"]
      true -> ["#{lower}->#{upper}"]
    end
  end
  def missing_bounds([head | rest], lower, upper) do
    cond do
      head >= upper -> missing_bounds([], lower, upper)
      (head - 1) < lower -> missing_bounds(rest, head + 1, upper)
      (head - 1) == lower -> ["#{head - 1}" | missing_bounds(rest, head + 1, upper)]
      true -> ["#{lower}->#{head - 1}" | missing_bounds(rest, head + 1, upper)]
    end
  end
end
