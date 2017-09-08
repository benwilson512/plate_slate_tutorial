defmodule PlateSlateWeb.Resolvers.Ordering do
  alias PlateSlate.{Ordering, Repo}
  import Ecto.Query

  def orders(_, args, _) do
    orders =
      PlateSlate.Ordering.Order
      |> filter(args)
      |> Repo.all

    {:ok, orders}
  end

  defp filter(query, %{state: state}) do
    query |> where(state: ^state)
  end
  defp filter(query, _), do: query

  def place_order(_, args, _) do
    args = Map.put(args, :schedule, Ordering.Order.random_schedule())
    Ordering.create_order(args)
  end
end
