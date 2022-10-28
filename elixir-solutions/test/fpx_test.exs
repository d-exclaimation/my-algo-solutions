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

  test "N Repeated" do
    source = [4, 2, 4, 1, 4, 6]
    given = Kth.n_repeated(source)
    expected = 4
    assert given == expected
  end

  test "Smallest window of sorting" do
    source = [2, 4, 7, 5, 6, 8, 9]
    given = Kth.smallest_window_sort(source)
    expected = {2, 4}
    assert given == expected
  end

  test "Three consecutive odd" do
    assert Kth.consecutive?([1, 3, 4, 2, 3, 9, 15], 3, fn x -> rem(x, 2) == 1 end)
    assert not Kth.consecutive?([1, 2, 3, 4, 5], 3, fn x -> rem(x, 2) == 1 end)
  end

  test "Soup and Salad side dishes" do
    customers0 = [1, 1, 1]
    sides0 = [1, 1, 1]
    expected0 = 0
    given0 = Engine.Restaurant.side_dish(customers0, sides0)

    assert expected0 == given0

    customers1 = [1, 0, 1]
    sides1 = [0, 0, 1]
    expected1 = 2
    given1 = Engine.Restaurant.side_dish(customers1, sides1)

    assert expected1 == given1
  end
end
