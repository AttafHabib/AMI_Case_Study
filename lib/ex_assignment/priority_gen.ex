defmodule ExAssignment.PriorityGenerator do
  @moduledoc """
  Generating a prioritized To Do.
  """

  @doc """
  Returns a random tag/id based on it's probability.

  ## Examples

      iex> get_probabilities([{1, 20}, {2, 50}])
      1

  """
  def get_probabilities(data) when is_list(data) do
    {inversed_priorities, sum} = inversed_priorities(data)

    normalizer = 1 / sum

    {probs, _x} =
      inversed_priorities
      |> Enum.map(fn {tag, priority} -> {tag, priority * normalizer} end)
      |> Enum.sort_by(&elem(&1, 1))
      |> comultative_probabilites()

    probs
    |> find_random()
    |> elem(0)
  end

  defp inversed_priorities(data) when is_list(data) do
    Enum.reduce(data, {[], 0}, fn {tag, val}, {list, sum} ->
      inverse_val = 1 / val
      updated_item = {tag, inverse_val}
      {[updated_item | list], sum + inverse_val}
    end)
  end

  defp comultative_probabilites(data) when is_list(data) do
    Enum.reduce(data, {[], 0}, fn {tag, val}, {list, sum} ->
      {list ++ [{tag, sum + val}], sum + val}
    end)
  end

  defp find_random(data) when is_list(data) do
    rand = :rand.uniform()
    Enum.find(data, &(elem(&1, 1) >= rand))
  end
end
