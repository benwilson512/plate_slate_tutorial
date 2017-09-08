defmodule PlateSlateWeb.Resolvers.Ordering do
  alias PlateSlate.Ordering

  def place_order(_, args, _) do
    args = Map.put(args, :schedule, Ordering.Order.random_schedule())
    Ordering.create_order(args)
  end
end
