#
#  my_math_test.exs
#  elixir-solutions
#
#  Created by d-exclaimation on 14:44.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule MyMathTest do
  @moduledoc """
    Test
  """
  use ExUnit.Case
  doctest FPX

  test "Continuous subarray max" do
    assert MyMath.max_continous([34, -50, 42, 14, -5, 86]) == 137
  end

  test "Fibonacci" do
    assert MyMath.fibonacci(3) == 2
  end
end
