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
  use Application

  @spec start(any, any) :: {:error, any} | {:ok, pid}
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    IO.puts([
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ] |> Matrix.Manipulation.diagonal_sum())

    # All children process to be supervised
    children = []
    opts = [strategy: :one_for_one, name: FPX.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
