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
    IO.puts("Attempt 2")
    IO.puts(Array.one_value([1, 2, 2, 2, 3, 3, 3]))
  end
end

FPX.run()