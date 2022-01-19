#
#  restaurant.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 05:21.
#

defmodule Engine.Restaurant do
  @moduledoc """
    Engine a restaurant system
  """

  @doc """
  Serving side dish to consumer
  A restaurant offers two potential sides to their dishes, soup or salad.

  All the side dishes in sides must be removed in order (i.e. the first side dish must be given to a customer before the next one can be given to a customer).
  If the customer at the front of the line’s preference aligns with the side dish that’s available, the customer can take the side dish and go to their table.
  If their preference does not align, the current side dish remains and the customer goes to the back of the line.

  Return the number of customers who could not receive their preferred side dish.
  """
  @spec side_dish([integer()], [integer()]) :: integer()
  def side_dish(customers, sides) do
    do_side_dish(customers, sides, 0)
  end

  @spec do_side_dish([integer()], [integer()], integer()) :: integer()

  defp do_side_dish([], _sides, not_sitting),
    do: not_sitting

  defp do_side_dish(remains, [], not_sitting),
    do: Enum.count(remains) + not_sitting

  defp do_side_dish([first_customer | rest_customers], [first_side | rest_sides], not_sitting)
       when first_customer == first_side,
       do: do_side_dish(rest_customers, rest_sides, not_sitting)

  defp do_side_dish([_ | rest_customers], sides, not_sitting),
    do: do_side_dish(rest_customers, sides, not_sitting + 1)
end
