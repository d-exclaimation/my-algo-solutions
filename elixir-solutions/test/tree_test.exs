#
#  tree_test.exs
#  elixir-solutions
#
#  Created by d-exclaimation on 14:58.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule FPX.TreeTest do
  @moduledoc """
    Tree Test
  """
  use ExUnit.Case
  doctest FPX

  test "Inverse a tree" do
    init = %Tree{
      val: 1,
      left: %Tree{
        val: 2,
        left: %Tree{
          val: 3
        },
        right: %Tree{
          val: 4
        }
      },
      right: %Tree{
        val: 5,
        left: %Tree{
          val: 6
        },
        right: %Tree{
          val: 7
        }
      }
    }

    expected = %Tree{
      val: 1,
      right: %Tree{
        val: 2,
        right: %Tree{
          val: 3
        },
        left: %Tree{
          val: 4
        }
      },
      left: %Tree{
        val: 5,
        right: %Tree{
          val: 6
        },
        left: %Tree{
          val: 7
        }
      }
    }

    assert Kernel.inspect(init |> Tree.inversed()) == Kernel.inspect(expected)
  end

  test "Max Depth Integer" do
    expected = 42

    root = %Tree{
      val: 12,
      left: %Tree{val: 10, right: %Tree{val: 20}, left: %Tree{val: 10}},
      right: %Tree{val: 30, left: %Tree{val: -40}}
    }

    assert Tree.Manipulation.max_total(root) == expected
  end

  test "Add tree" do
    lhs = %Tree{
      val: 1,
      left: %Tree{val: 2}
    }

    rhs = %Tree{
      val: 3,
      left: %Tree{val: 4}
    }

    res = lhs |> Tree.Manipulation.add(rhs)
    expected = %Tree{val: 4, left: %Tree{val: 6}}
    assert res.val == expected.val
    assert res.left.val == expected.left.val
  end

  test "Fast heapify" do
    dataset = [3, 69, 1, 420]
    resolver = fn l, r -> l >= r end
    given = Heap.fast_heapify(dataset, resolver)

    expected =
      dataset
      |> Enum.reduce(Heap.new(resolver), fn x, acc -> Heap.put(acc, x) end)

    assert inspect(given) == inspect(expected)
  end

  test "Minimum depth" do
    root = %Tree{
      val: 1,
      left: %Tree{val: 2},
      right: %Tree{val: 3, left: %Tree{val: 4}}
    }

    assert Tree.min_depth(root) == 2
  end
end
