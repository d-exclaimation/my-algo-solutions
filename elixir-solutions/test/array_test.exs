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

  test "Unique values" do
    assert Array.unique([1, 3, 2, 3, 2]) == [1]
    assert Array.unique([3, 2, 3, 2]) == []

    assert MapSet.difference(MapSet.new(Array.unique([3, 2, 1])), MapSet.new([3, 2, 1])) ==
             MapSet.new([])
  end
end
