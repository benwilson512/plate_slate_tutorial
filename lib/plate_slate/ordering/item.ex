defmodule PlateSlate.Ordering.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias PlateSlate.Ordering.Item


  schema "order_items" do
    field :price, :decimal
    field :quantity, :integer
    belongs_to :order, PlateSlate.Ordering.Order
    belongs_to :menu_item, PlateSlate.Menu.Item

    timestamps()
  end

  @doc false
  def changeset(%Item{} = item, attrs) do
    item
    |> cast(attrs, [:price, :quantity, :menu_item_id])
    |> validate_required([:price, :quantity])
  end
end
