#
#  Kth.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 9:33 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Kth do
  @moduledoc """
  Kth Something
  """

  @doc """
  Kth closest
  """
  def closest_pivots(list, k, pivot) do
    list
    |> Enum.map(fn item -> %{val: item, close: abs(pivot - item)} end)
    |> Enum.sort_by(fn map -> map.close end)
    |> Enum.slice(0..k - 1)
    |> Enum.map(fn map -> map.val end)
  end

  @doc """
  Find duplicate if only one is duplicated
  """
  def find_one_dup(arr) do
    _find_one_dup(arr, MapSet.new())
  end

  defp _find_one_dup(arr, _seen) when length(arr) == 0, do: nil
  defp _find_one_dup([head | rest], seen) do
    cond do
      MapSet.member?(seen, head) -> head
      true -> _find_one_dup(rest, seen |> MapSet.put(head))
    end
  end

end
