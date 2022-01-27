#
#  probabilities.ex
#  elixir-solutions
#
#  Created by d-exclaimation on 23:47.
#

defmodule Probabilities do
  @moduledoc """
    Probabilities module
  """

  @doc """
  The number of combination for `n` times dice with `max_val` sides to get a sum of `target`.
  """
  @spec dice_combo(%{n: non_neg_integer(), max_val: non_neg_integer(), target: non_neg_integer()}) ::
          non_neg_integer()
  def dice_combo(%{n: 0}), do: 0

  def dice_combo(%{n: n, max_val: max_val, target: target}) do
    1..max_val
    |> Enum.to_list()
    |> Enum.filter(fn x -> x <= target end)
    |> Enum.map(fn
      ^target ->
        if n == 1, do: 1, else: 0

      i ->
        dice_combo(%{
          n: n - 1,
          max_val: target,
          target: target - i
        })
    end)
    |> Enum.sum()
  end

  @doc """
  Situations where you count the number of successes in a fixed num
  ber of trials, `n`, where each trial is independent and there is a constant probability of success.
  """
  @spec binomial(%{n: non_neg_integer(), prob: float()}) :: (non_neg_integer() -> number())
  def binomial(%{n: n, prob: prob}) do
    fn
      a when a > n ->
        0

      x ->
        combination(n, x) * prob ** x * (1 - prob) ** (n - x)
    end
  end

  @spec combination(non_neg_integer(), non_neg_integer()) :: number()
  def combination(n, x) do
    factorial(n) / (factorial(n - x) * factorial(x))
  end

  @spec factorial(non_neg_integer()) :: non_neg_integer()
  def factorial(0), do: 1

  def factorial(n) do
    1..n
    |> Enum.to_list()
    |> Enum.reduce(fn x, acc -> x * acc end)
  end
end
