defmodule PlateSlateWeb.Resolvers.Ordering do
  alias PlateSlate.Ordering

  def place_order(_, args, _) do
    with {:ok, order} <- Ordering.create_order(args) do
      pubsub = PlateSlateWeb.Endpoint
      Absinthe.Subscription.publish(pubsub, order, order_placed: "*")
      {:ok, order}
    end
  end
end
