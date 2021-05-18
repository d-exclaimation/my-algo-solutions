#
#  roman_numeral.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 22:11.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule RomanNumeral do
  @moduledoc """
    Roman numerals
  """

  @doc """
  Convert back to integer
  """
  @spec to_integer(String.t()) :: integer
  def to_integer(roman) do
    {res, _} =
      roman
      |> String.to_charlist()
      |> Enum.reverse()
      |> Enum.map(fn
        ?I -> 1
        ?V -> 5
        ?X -> 10
        ?L -> 50
        ?C -> 100
        ?D -> 500
        ?M -> 1000
        _ -> 0
      end)
      |> Enum.reduce({0, 0}, fn x, {acc, prev} ->
        cond do
          x < prev -> {acc - x, prev}
          true -> {acc + x, max(prev, x)}
        end
      end)

    res
  end
end
