defmodule NodeTest do
  use ExUnit.Case
  doctest LinkedList
  doctest LinkedNode

  test "Detect cycle" do
    linked_list = %LinkedList{
      curr: 0,
      data: [
        {10, 1},
        {12, 2},
        {13, 3},
        {5, 1}
      ]
    }

    assert LinkedList.cycle?(linked_list)
  end
end
