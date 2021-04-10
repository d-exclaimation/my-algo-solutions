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
    IO.inspect(MyMath.bigger_and_bigger([2, 4, 3, 6]), charlist: :as_lists)
  end
end

FPX.run()