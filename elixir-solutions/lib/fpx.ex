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

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    IO.puts(Polygon.max_connected_dots([
      [1, 0, 0, 1],
      [1, 1, 1, 1],
      [0, 1, 0, 0]
    ]))

    # All children process to be supervised
    children = []
    opts = [strategy: :one_for_one, name: FPX.Supervisor]
    Supervisor.start_link(children, opts)
  end
end