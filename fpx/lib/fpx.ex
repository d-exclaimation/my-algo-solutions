#
#  fpx.ex
#  fpx
#
#  Created by d-exclaimation on 8:02 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule FPX do
  @moduledoc """
  Documentation for `FPX`.
  """

  @doc """
  Main initialize function
  """
  def run do
    IO.puts(MyMath.square_root(6))
  end
end

FPX.run()