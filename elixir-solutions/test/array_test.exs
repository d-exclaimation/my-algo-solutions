defmodule ArrayTest do
  use ExUnit.Case
  doctest Array

  test "Intersection of sorted lis" do
    assert Array.intersection_sorted(
             [1, 2, 3],
             [1, 2],
             [1]
           ) == [1]

    assert Array.intersection_sorted(
             [1, 2, 3],
             [4, 5, 6],
             [7, 8, 9]
           ) == []
  end
end
