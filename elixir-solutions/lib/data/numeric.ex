#
#  Numeric.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 11:07 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Numeric do
  @moduledoc """
  Numeric Module for Integer and Floats
  """

  @type numeric :: integer() | float()

  defmacro return(x), do: x


  @doc """
  Check if palindrome
  -> val: numeric
  :: boolean
  """
  @spec palindrome?(numeric()) :: boolean()
  def palindrome?(val) when div(val, 10) == 0, do: true
  def palindrome?(val), do: val == reversed(val)

  @doc """
  Reverse a numeric
  -> val: numeric
  :: numeric
  """
  @spec reversed(numeric()) :: numeric()
  def reversed(val) when div(val, 10) == 0, do: val
  def reversed(val) do
    last = rem(val, 10)
    remain = div(val, 10)
    base = :math.pow(10, ("#{remain}" |> String.to_charlist() |> length()))
    return last * (base |> round()) + reversed(remain)
  end

end
