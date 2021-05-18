#
#  operators.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 11:36.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Numeric.Operators do
  @moduledoc """
   Numerical operator used
  """

  @doc """
  Power operator
  """
  def _ >>> 0, do: 1

  def a >>> b do
    half = a >>> div(b, 2)

    cond do
      rem(b, 2) == 0 -> half * half
      true -> half * half * a
    end
  end
end
