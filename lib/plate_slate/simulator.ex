defmodule Simulator do
  def stream do
    alias PlateSlate.{Repo, Ordering}

    random_item = fn ->
      order = PlateSlate.Menu.Item
      |> Repo.random

      %{
        quantity: :rand.uniform(3),
        menu_item_id: order.id
      }
    end

    item_generator = Stream.repeatedly(random_item)

    Stream.iterate(0, &(&1 + 1)) |> Stream.each(fn i ->
      attrs = %{
        customer_number: i,
        items: item_generator |> Enum.take(3),
        schedule: Ordering.Order.random_schedule(),
      }
      {:ok, order} = PlateSlate.Ordering.create_order(attrs)
      Absinthe.Subscription.publish(PlateSlateWeb.Endpoint, order, order_updated: "*")
      :timer.sleep(1_000)
    end)
  end

  def run do
    spawn(fn -> stream() |> Stream.run() end)
  end
end
