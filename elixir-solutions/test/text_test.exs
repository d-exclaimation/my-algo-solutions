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

  test "Palindromable" do
    assert Character.palindromable?("aeae")
    assert not Character.palindromable?("hlloleh")
  end

  test "Programming string" do
    assert Character.form_count("mingabcprojklgram", "programming") == 1
    assert Character.form_count("rammingabcprogrammingdefprog", "programming") == 2
  end

  test "Mapping key values" do
    assert %{97 => 98} == Character.map(String.to_charlist("a"), String.to_charlist("b"))
  end

  test "Mappable" do
    assert Character.mappable?("abc", "def")
    assert not Character.mappable?("aba", "def")
  end

  test "Lowercase" do
    assert Character.lowercase("ABC") == "abc"
    assert Character.lowercase("ABc") == "abc"
  end

  test "Smallest Lex" do
    queries = ["abc"]
    words = ["def"]
    assert Character.smallest_count_letter(queries, words) == [0]

    assert Character.smallest_count_letter(["abc"], ["ddef", "xxyz"]) == [2]
  end

  test "Evenly / Equaly distributed Vowels" do
    import Array
    queries = ["laptop", "computer"]
    expected = [true, false]

    for {given, should} <- Enum.map(queries, &Vowel.evenly_vowel/1) |> Enum.zip(expected) do
      assert given == should
    end
  end
end
