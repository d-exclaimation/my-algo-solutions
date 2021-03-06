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

  test "Matching index and values" do
    assert 0 == Array.matching_index_values([0, 3, 2])
    assert -1 == Array.matching_index_values([1, 3, 4, 5])
  end

  test "Operator mix side by side" do
    import Array
    assert [{1, 1}, {2, 2}] == [1, 2] <|> [1, 2]
    assert [{1, 1}, {2, nil}] == [1, 2] <|> [1]
    assert [{1, 1}, {nil, 2}] == [1] <|> [1, 2]
  end
end
