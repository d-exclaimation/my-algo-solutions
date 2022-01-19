#
#  vowel.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 06:02.
#

defmodule Vowel do
  @moduledoc """
    Vowels and its uses
  """

  @valids ["a", "i", "u", "e", "o"]

  @doc """
  CHeck if each halves of this string has equal / evenly distributed vowels
  """
  @spec evenly_vowel(String.t()) :: boolean()
  def evenly_vowel(str) do
    chars =
      str
      |> String.graphemes()

    half_point =
      if rem(Enum.count(chars), 2) == 0,
        do: div(Enum.count(chars), 2) - 1,
        else: div(Enum.count(chars), 2)

    first_halves =
      chars
      |> Enum.slice(0..half_point)
      |> Enum.join("")

    second_halves =
      if(
        Enum.count(chars) <= half_point,
        do: [],
        else: chars |> Enum.slice((half_point + 1)..-1)
      )
      |> Enum.join("")

    count(first_halves) == count(second_halves)
  end

  @doc """
  Count the number of Vowel from a string
  """
  @spec count([binary()]) :: integer()
  def count([_first | _rest] = graphemes) do
    graphemes
    |> Enum.filter(&is/1)
    |> Enum.count()
  end

  @spec count(String.t()) :: integer()
  def count(str) do
    str
    |> String.graphemes()
    |> Enum.filter(&is/1)
    |> Enum.count()
  end

  @doc """
  Check if character is a vowel
  """
  @spec is(String.t()) :: boolean()
  def is(str) when length(str) != 1, do: false

  def is(char) do
    @valids
    |> MapSet.new()
    |> MapSet.member?(char)
  end
end
