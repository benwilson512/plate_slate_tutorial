defmodule PlateSlate.Ordering do
  @moduledoc """
  The Ordering context.
  """

  import Ecto.Query, warn: false
  alias PlateSlate.Repo

  alias PlateSlate.Ordering.Order

  @doc """
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders(filters) do
    filters
    |> Enum.reduce(Order, fn
      {:state, state}, query ->
        query |> where(state: ^state)
      _, query ->
        query
    end)
    |> Repo.all
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    attrs = Map.update(attrs, :items, [], &build_items/1)

    %Order{
      state: "created",
      ordered_at: DateTime.utc_now,
    }
    |> Order.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, order} ->
        order = %{order | items: %Order{}.items}
        advance(order)
        {:ok, order}
    end
  end

  # All the following spawn stuff is totally insane, don't ever do this in production.
  # This exists soley to simulate some other actions happening to the order, and in a
  # way that was totally thrown together at the last moment.

  def advance(%{state: "created"} = order) do
    items = order |> Ecto.assoc(:items) |> Repo.all
    spawn(fn -> update_eventually(order, items) end)
  end
  def advance(%{state: "ready"} = order) do
    spawn(fn ->
      complete_eventually(order)
    end)
  end

  defp complete_eventually(order) do
    order_completion_time = Application.get_env(:plate_slate, :time)
    :timer.sleep(:rand.uniform(order_completion_time))
    order =
      order
      |> Ecto.Changeset.change(%{state: "completed"})
      |> Repo.update!

    Absinthe.Subscription.publish(PlateSlateWeb.Endpoint, order, order_updated: "*")
  end

  defp update_eventually(order, []) do
    order =
      order
      |> Ecto.Changeset.change(%{state: "ready"})
      |> Repo.update!

    Absinthe.Subscription.publish(PlateSlateWeb.Endpoint, order, order_updated: "*")
    complete_eventually(order)
  end

  defp update_eventually(order, [item | items]) do
    order_item_time = Application.get_env(:plate_slate, :time)
    time = :rand.uniform(order_item_time) * Order.schedule_modifier(order.schedule)
    :timer.sleep(trunc(time))

    item =
      item
      |> Ecto.Changeset.change(%{state: "completed"})
      |> Repo.update!

    Absinthe.Subscription.publish(PlateSlateWeb.Endpoint, item, order_item_completed: "*")

    update_eventually(order, items)
  end

  defp build_items(items) do
    for item <- items do
      menu_item = PlateSlate.Menu.Item |> Repo.get!(item.menu_item_id)
      %{menu_item_id: menu_item.id, quantity: item.quantity, price: menu_item.price}
    end
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{source: %Order{}}

  """
  def change_order(%Order{} = order) do
    Order.changeset(order, %{})
  end
end
