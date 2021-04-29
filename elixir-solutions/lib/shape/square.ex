#
#  Square.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 10:22 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Square do
  @moduledoc """
  Square polygon
  """
  defstruct topleft: {0, 0}, width: 0, height: 0
end

defmodule Squared do
  @moduledoc """
  Square specific module
  """

  @doc """
  List to square
  """
  def to_square(list) when length(list) == 4 do
    %Square{
      topleft: {Enum.at(list, 0), Enum.at(list, 1)},
      width: abs(Enum.at(list, 2) - Enum.at(list, 0)),
      height: abs(Enum.at(list, 3) - Enum.at(list, 1))
    }
  end
  @doc """
  Collide?
  """
  def collide?(lhs, rhs) do
    _collide?(lhs, rhs) or _collide?(rhs, lhs)
  end

  defp _collide?(lhs, rhs) do
    {x1, y1} = lhs.topleft
    {x2, y2} = rhs.topleft
    (x1 <= x2 and x2 < x1 + lhs.width) and (y1 <= y2 and y2 < y1 + lhs.height)
  end
end
