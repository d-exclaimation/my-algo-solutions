#
#  roman_numeral_test.exs
#  elixir-solutions
#
#  Created by d-exclaimation on 22:21.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule RomanNumeralTest do
  @moduledoc """

  """
  use ExUnit.Case
  doctest RomanNumeral

  test "Roman to integer" do
    assert RomanNumeral.to_integer("MCMX") == 1910
  end
end
