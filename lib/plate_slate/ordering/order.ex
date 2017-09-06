defmodule PlateSlate.Ordering.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias PlateSlate.Ordering.Order


  schema "orders" do
    field :customer_number, :integer
    field :ordered_at, :utc_datetime
    field :state, :string

    timestamps()
  end

  @doc false
  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, [:customer_number, :ordered_at, :state])
    |> validate_required([:customer_number, :ordered_at, :state])
  end
end
