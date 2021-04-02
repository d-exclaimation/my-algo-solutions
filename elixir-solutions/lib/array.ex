#
#  Array.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 7:23 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Array do
  @moduledoc """
  Array manipulation
  """

  def rotate_1d([head | rest], count) when count == 0, do: [head] ++ rest
  def rotate_1d([head | rest], count) do
    rotate_1d(rest ++ [head], count - 1)
  end
end
