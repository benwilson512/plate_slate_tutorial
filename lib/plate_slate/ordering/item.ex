defmodule PlateSlate.Ordering.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias PlateSlate.Ordering.Item


  schema "order_items" do
    field :price, :decimal
    field :quantity, :integer
    field :order_id, :id
    field :menu_item_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Item{} = item, attrs) do
    item
    |> cast(attrs, [:price, :quantity, :menu_item_id])
    |> validate_required([:price, :quantity])
  end
end
