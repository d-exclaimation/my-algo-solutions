#
#  fpx.ex
#  fpx
#
#  Created by d-exclaimation on 8:02 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule FPX do
  @moduledoc """
  Module for `FPX` Application.
  """

  @doc """
  Main initialize function
  """
  def run do
    {lhs, mhs, rhs} = Array.three_sum([1, 2, 3, 4, 5], 6)
    IO.puts("#{lhs}, #{mhs} and #{rhs}")
  end
end

FPX.run()