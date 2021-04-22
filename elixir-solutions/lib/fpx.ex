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

    oak = %LinkedNode{
      val: 1,
      next: %LinkedNode{
        val: 1,
        next: %LinkedNode{val: 2}
      }
    }
    IO.inspect(oak)
    IO.inspect(oak |> LinkedNode.remove_sorted())

    # All children process to be supervised
    children = []
    opts = [strategy: :one_for_one, name: FPX.Supervisor]
    Supervisor.start_link(children, opts)
  end
end