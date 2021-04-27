#
#  Numeric.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 11:07 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Numeric do
  @moduledoc """
  Numeric Module for Integer and Floats
  """

  @type numeric :: integer() | float()

  defmacro return(x), do: x


  @doc """
  Check if palindrome
  -> val: numeric
  :: boolean
  """
  @spec palindrome?(numeric()) :: boolean()
  def palindrome?(val) when div(val, 10) == 0, do: true
  def palindrome?(val), do: val == reversed(val)

  @doc """
  Reverse a numeric
  -> val: numeric
  :: numeric
  """
  @spec reversed(numeric()) :: numeric()
  def reversed(val) when div(val, 10) == 0, do: val
  def reversed(val) do
    do_reversed(val, 0)
  end

  @spec do_reversed(numeric(), numeric()) :: numeric()
  defp do_reversed(val, prev) when div(val, 10) == 0, do: prev * 10 + val
  defp do_reversed(val, prev) do
    do_reversed(div(val, 10), prev * 10 + rem(val, 10))
  end

  @doc """
  Check if a number
  -> exp: String.t
  :: boolean
  """
  def number?(exp) do
    [first | rest] = String.graphemes(exp)
    cond do
      first == "-" -> _number?(rest, false, false)
      true -> _number?([first | rest], false, false)
    end
  end

  # O(n) time x _digit? time
  defp _number?([head | rest], float, scientific) when length(rest) == 0 do
    not_special = not float and not scientific
    (head == "." and not_special) or (head == "e" and not scientific) or _digit?(head)
  end
  defp _number?([head | rest], float, scientific) do
    cond do
      head == "." -> not float and not scientific and _number?(rest, true, scientific)
      head == "e" -> not scientific and _number?(rest, float, true)
      _digit?(head) -> true and _number?(rest, float, scientific)
      true -> false
    end
  end

  # O(n) time
  defp _digit?(grapheme) do
    ["1","2","3","4","5","6","7","8","9","0"]
    |> Enum.member?(grapheme)
  end

end
