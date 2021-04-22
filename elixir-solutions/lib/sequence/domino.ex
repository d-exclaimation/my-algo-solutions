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
  -> dominoes: list(integer)
  :: list(integer)
  """
  def weighted_dominoes(dominoes) do
    _weighted_dominoes(dominoes, 0)
  end

  defp _weighted_dominoes(dominoes, prev) when length(dominoes) <= 0, do: if prev == 0, do: [], else: [prev]
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

end
