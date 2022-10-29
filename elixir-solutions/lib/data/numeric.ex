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
  """
  @spec palindrome?(numeric()) :: boolean()
  def palindrome?(val) when div(val, 10) == 0, do: true
  def palindrome?(val), do: val == reversed(val)

  @doc """
  Reverse a numeric
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
  """
  @spec number?(binary) :: boolean
  def number?(exp) do
    [first | rest] = String.graphemes(exp)

    cond do
      first == "-" -> _number?(rest, false, false)
      true -> _number?([first | rest], false, false)
    end
  end

  # O(n) time x _digit? time
  @spec _number?(list(String.t()), boolean(), boolean()) :: boolean()
  defp _number?([head | rest], float, scientific) when length(rest) == 0 do
    not_special = not float and not scientific
    (head == "." and not_special) or (head == "e" and not scientific) or _digit?(head)
  end

  defp _number?([head | rest], float, scientific) do
    cond do
      head == "." -> not float and not scientific and _number?(rest, true, scientific)
      head == "e" -> not scientific and _number?(rest, float, true)
      _digit?(head) -> _number?(rest, float, scientific)
      true -> false
    end
  end

  # O(n) time
  defp _digit?(grapheme) do
    ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    |> Enum.member?(grapheme)
  end

  @doc """
  Convert from string to numeric
  """
  @spec from_string(String.t()) :: numeric()
  def from_string(string) do
    if number?(string) do
      case convert_to_numeric(String.graphemes(string), 0) do
        :error -> String.to_float(string)
        val -> val
      end
    else
      throw("Cannot convert")
    end
  end

  @digit %{
    "0" => 0,
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9
  }

  @spec convert_to_numeric(list(String.t()), numeric()) :: numeric() | :error
  defp convert_to_numeric([], carry), do: carry

  defp convert_to_numeric([head | rest], carry) when head == "-" and carry == 0,
    do: convert_to_numeric(rest, carry * -1)

  defp convert_to_numeric([head | rest], carry) do
    case Map.has_key?(@digit, head) do
      true -> convert_to_numeric(rest, carry * 10 + @digit[head])
      false -> :error
    end
  end

  @doc """
  Count the amount of numbers that conform to a rule
  """
  @spec count_digits([integer], (integer -> boolean)) :: integer
  def count_digits(arr, rule) do
    arr
    |> Enum.filter(rule)
    |> Enum.count()
  end

  @doc """
  Perfect number
  """
  @spec perfect(num :: non_neg_integer()) :: boolean()
  def perfect(num) do
    res =
      1..div(num, 2)
      |> Enum.filter(fn x -> rem(num, x) == 0 end)
      |> Enum.sum()

    res == num
  end

  @doc """
  Maximum number if given an integer with only 6s and 9s digits
  """
  @spec max_six_nine(non_neg_integer()) :: non_neg_integer()
  def max_six_nine(num) do
    {res, _is} =
      num
      |> BaseTen.digits()
      |> Enum.reduce({0, false}, fn
        6, {acc, false} -> {acc * 10 + 9, true}
        x, {acc, is} -> {acc * 10 + x, is}
      end)

    res
  end
end
