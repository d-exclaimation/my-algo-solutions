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

  test "Flatten and spread map" do
    import Array

    input = [
      %{
        name: "a1",
        arr1: [%{name: "aa1"}, %{name: "aa2"}, %{name: "aa3"}],
        arr2: [%{name: "a21"}]
      },
      %{
        name: "a2",
        arr1: [%{name: "a22"}, %{name: "a23"}],
        arr2: [%{name: "a31"}, %{name: "a32"}]
      }
    ]

    expected = [
      %{name: "a1", arr1: %{name: "aa1"}, arr2: %{name: "a21"}},
      %{name: "a1", arr1: %{name: "aa2"}, arr2: nil},
      %{name: "a1", arr1: %{name: "aa3"}, arr2: nil},
      %{name: "a2", arr1: %{name: "a22"}, arr2: %{name: "a31"}},
      %{name: "a2", arr1: %{name: "a23"}, arr2: %{name: "a32"}}
    ]

    res = MapSplit.split_reduce(input)

    assert length(expected) == length(res)

    for {exp, given} <- expected <|> res do
      assert inspect(exp) == inspect(given)
    end
  end
end
