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
  def list_orders do
    Repo.all(Order)
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
        items = order |> Ecto.assoc(:items) |> Repo.all
        order = %{order | items: %Order{}.items}
        spawn(fn -> update_eventually(order, items) end)
        {:ok, order}
    end
  end

  defp update_eventually(order, []) do
    order
    |> Ecto.Changeset.change(%{state: "completed"})
    |> Repo.update!
    |> broadcast
  end

  defp update_eventually(order, [item | items]) do
    :timer.sleep(:rand.uniform(5_000))

    item
    |> Ecto.Changeset.change(%{state: "completed"})
    |> Repo.update!
    order |> IO.inspect
    broadcast(order)

    update_eventually(order, items)
  end

  defp broadcast(order) do
    Absinthe.Subscription.publish(PlateSlateWeb.Endpoint, order, order_updated: "*")
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
