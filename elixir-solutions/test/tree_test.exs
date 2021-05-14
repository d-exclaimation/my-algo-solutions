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
end
