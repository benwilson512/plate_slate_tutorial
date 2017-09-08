defmodule PlateSlate.Ordering.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias PlateSlate.Ordering.Order


  schema "orders" do
    field :customer_number, :integer, read_after_writes: true
    field :ordered_at, :utc_datetime
    field :state, :string
    field :schedule, :string

    has_many :items, PlateSlate.Ordering.Item

    timestamps()
  end

  def random_schedule do
    schedule_possibilities = List.duplicate("normal", 7) ++ ["priority", "priority"] ++ ["rush"]
    Enum.at(schedule_possibilities, :rand.uniform(length(schedule_possibilities) - 1))
  end

  def schedule_modifier("normal"), do: 1.0
  def schedule_modifier("priority"),   do: 0.5
  def schedule_modifier("rush"),   do: 0.25

  @doc false
  def changeset(%Order{} = order, attrs) do
    order
    |> cast(attrs, [:ordered_at, :state, :schedule])
    |> cast_assoc(:items)
    |> validate_required([:ordered_at, :state])
  end
end
