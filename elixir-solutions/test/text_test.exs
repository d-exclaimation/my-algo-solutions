defmodule TextTest do
  use ExUnit.Case
  doctest Character

  test "String compression" do
    res =
      ["a", "a", "b", "c", "c", "c"]
      |> Character.compressed()
      |> Enum.join()

    expected = "a2bc3"
    assert(res == expected)
  end
end
