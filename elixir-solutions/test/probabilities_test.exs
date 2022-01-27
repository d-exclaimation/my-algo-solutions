defmodule ProbabilitiesTest do
  use ExUnit.Case
  doctest Probabilities

  test "Dice roll combination" do
    assert Probabilities.dice_combo(%{n: 1, max_val: 6, target: 5}) == 1
    assert Probabilities.dice_combo(%{n: 2, max_val: 6, target: 4}) == 3
  end

  test "Binomial random distribution" do
    f = Probabilities.binomial(%{n: 2, prob: 1 / 2})
    assert f.(2) == 1 / 2 * (1 / 2)

    assert f.(1) == 2 * (1 / 2) ** 2
  end
end
