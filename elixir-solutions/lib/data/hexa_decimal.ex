#
#  hexa_decimal.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 13:34.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule HexaDecimal do
  @moduledoc """
    HexaDecimal Numeric based module
  """

  @typedoc """
  Base 16 representation of a integer using a String.t
  """
  @type hexa :: String.t()

  @hexa_letter %{
    10 => "a",
    11 => "b",
    12 => "c",
    13 => "d",
    14 => "e",
    15 => "f"
  }

  @doc """
  Convert from integer
  """
  @spec from(integer()) :: String.t()
  def from(num) do
    # Get the first remainder from 16
    # convert to proper hexa digits
    # append from of the rest if any
    curr = rem(num, 16)
    rest = div(num, 16)
    if rest > 0, do: from(rest) <> hexa_digit(curr), else: hexa_digit(curr)
  end

  @doc """
  Convert a digit into hexadigit
  """
  @spec hexa_digit(integer()) :: String.t()
  def hexa_digit(digit) do
    cond do
      digit < 10 -> "#{digit}"
      true -> @hexa_letter[digit]
    end
  end
end
