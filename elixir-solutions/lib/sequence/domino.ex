#
#  Domino.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 3:13 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Domino do
  @moduledoc """
  Domino effect module
  """

  @doc """
  Weighted dominoes simulation
  """
  @spec weighted_dominoes(list) :: [number]
  def weighted_dominoes(dominoes) do
    _weighted_dominoes(dominoes, 0)
  end

  defp _weighted_dominoes(dominoes, prev) when length(dominoes) <= 0,
    do: if(prev == 0, do: [], else: [prev])

  defp _weighted_dominoes([head | tail], prev) do
    if head < 0 do
      cond do
        prev + head > 0 -> _weighted_dominoes(tail, prev)
        prev + head < 0 -> [head | _weighted_dominoes(tail, 0)]
        true -> _weighted_dominoes(tail, 0)
      end
    else
      cond do
        prev - head < 0 -> _weighted_dominoes(tail, head)
        prev - head > 0 -> [prev | _weighted_dominoes(tail, 0)]
        true -> _weighted_dominoes(tail, 0)
      end
    end
  end

  @doc """
  Maximum sum of min pairs
  """
  @spec max_min_pairs([integer()]) :: integer()
  def max_min_pairs(arr) do
    res =
      arr
      |> Enum.sort()

    0..(length(res) - 1)
    |> Enum.filter(fn i -> rem(i, 2) == 0 end)
    |> Enum.map(fn i -> Enum.at(res, i) end)
    |> Enum.sum()
  end

  @doc """
  """
  @spec max_subarray([number()], integer()) :: number()
  def max_subarray(arr, k) do
    0..(length(arr) - k)
    |> Enum.map(fn i -> Enum.sum(Enum.slice(arr, i..(i + k - 1))) end)
    |> Enum.max()
  end
end
