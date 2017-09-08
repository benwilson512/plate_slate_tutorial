defmodule PlateSlateWeb.Resolvers.Ordering do
  alias PlateSlate.{Ordering}

  def orders(_, args, _) do
    {:ok, Ordering.list_orders(args)}
  end

  def place_order(_, args, _) do
    args = Map.put(args, :schedule, Ordering.Order.random_schedule())
    Ordering.create_order(args)
  end
end
