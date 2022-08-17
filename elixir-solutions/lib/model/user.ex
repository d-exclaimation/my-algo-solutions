#
#  user.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 11:44.
#  Copyright © 2022 d-exclaimation. All rights reserved.
#

defmodule Model.User do
  @moduledoc """
  A User model
  """
  use TypedStruct

  typedstruct do
    @typedoc "S user model"
    field(:id, String.t(), enforce: true)
  end
end
