defmodule NumericTest do
  use ExUnit.Case
  doctest Numeric

  test "Count numbers that have even digits" do
    assert Numeric.count_digits(
             [1, 12, 123],
             fn x -> rem(String.length("#{x}"), 2) == 0 end
           )
  end
end
