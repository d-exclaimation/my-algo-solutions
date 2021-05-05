#
#  Turns.ex
#  Default (Template) Project
#
#  Created by d-exclaimation on 10:34 AM.
#  Copyright © 2021 d-exclaimation. All rights reserved.
#

defmodule Turns do
  @moduledoc """
  Turn-based game / engine DSA Questions
  """

  @doc """
  Penny game, choose from front or back
  """
  @spec penny_picking?(list(integer())) :: boolean()
  def penny_picking?(piles), do: do_penny_picking?(piles, 0, 0, true)

  @spec do_penny_picking?(list(integer()), integer(), integer(), boolean) :: boolean()
  defp do_penny_picking?(piles, you, enemy, _yours?) when length(piles) == 0, do: you > enemy

  defp do_penny_picking?(piles, you, enemy, yours?) do
    first? = Enum.at(piles, 0) >= Enum.at(piles, -1)
    better_choice = if first?, do: 0, else: -1
    lesser_range = if first?, do: 1..-1, else: 0..-2

    if yours? do
      do_penny_picking?(
        Enum.slice(piles, lesser_range),
        you + Enum.at(piles, better_choice),
        enemy,
        !yours?
      )
    else
      do_penny_picking?(
        Enum.slice(piles, lesser_range),
        you,
        enemy + Enum.at(piles, better_choice),
        !yours?
      )
    end
  end
end
