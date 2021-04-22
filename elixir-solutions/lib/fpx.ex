#
#  fpx.ex
#  fpx
#
#  Created by d-exclaimation on 8:02 PM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule FPX do
  use Application
  @moduledoc """
  Module for `FPX` Application.
  """

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    IO.inspect(Limit.missing_dup([1, 2, 3, 5, 5]))

    # All children process to be supervised
    children = []
    opts = [strategy: :one_for_one, name: FPX.Supervisor]
    Supervisor.start_link(children, opts)
  end
end