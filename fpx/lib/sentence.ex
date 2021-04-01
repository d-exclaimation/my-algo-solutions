#
#  Sentence.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 2:05 AM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Sentence do
  @moduledoc """
  Sentences, words and strings manipulation
  """

  @doc """
  Last word's length (Before space)
  Take a string
  Return an integer
  """
  @spec last_word_length(String.t()) :: integer()
  def last_word_length(string) do
    last = String.last(string)
    if last == " " do
      0
    else
      1 + last_word_length(String.slice(string, 0..-2))
    end
  end

end
