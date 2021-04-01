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
    IO.puts(Sentence.last_word_length("The Daily Byte"))
  end
end

FPX.run()