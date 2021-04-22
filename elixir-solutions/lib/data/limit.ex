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
  -> start, target: integer
  :: integer
  """
  @spec min_operation(integer(), integer()) :: nil
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
  -> arr: list(integer)
  :: miss_n_dup
  """
  @spec missing_dup(list(integer())) :: miss_n_dup()
  def missing_dup(arr) do
    n = length(arr)
    dup = Kth.find_one_dup(arr)
    %{missing: dup + div(n * (n + 1), 2) - Enum.sum(arr), duplicate: dup}
  end
end
