#
#  base_ten.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 22:26.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule BaseTen do
  @moduledoc """
    Base10 Numeric
  """
  @doc """
  """
  @spec plus([integer], integer) :: [integer]
  def plus(arr, increment) do
    arr
    |> Enum.reverse()
    |> do_plus(increment)
    |> Enum.reverse()
  end

  defp do_plus([], 0), do: []
  defp do_plus([], carry), do: [carry]

  defp do_plus([head | rest], carry) do
    acc = carry + head
    base = rem(acc, 10)
    [base | do_plus(rest, div(acc, 10))]
  end
end
