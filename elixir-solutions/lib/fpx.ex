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
    IO.puts("Attempt 5")
    IO.inspect(Array.rotate_1d([1, 2, 3, 4, 5], 2), charlists: :as_list)
  end
end

FPX.run()