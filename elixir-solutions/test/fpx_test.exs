defmodule FPXTest do
  use ExUnit.Case
  doctest FPX

  test "Rearrange string character" do
    assert Sentence.rearrange("abc", [2, 0, 1])
    assert Sentence.rearrange("vincent", [0, 1, 2, 3, 4, 5, 6])
  end

  test "Plus one array" do
    assert [1, 2, 3] = BaseTen.plus([1, 2, 2], 1)
  end
end
