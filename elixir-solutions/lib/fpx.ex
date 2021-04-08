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
    IO.inspect(PhoneNumber.make_valid_words([3, 6, 4], ["dog", "fish", "cat", "fog"]))
  end
end

FPX.run()