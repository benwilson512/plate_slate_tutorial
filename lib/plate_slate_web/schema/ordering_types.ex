defmodule PlateSlateWeb.Schema.OrderingTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: PlateSlate.Repo

  input_object :place_order_input do
    field :quantity, non_null(:integer)
    field :menu_item_id, non_null(:id)
  end

  object :order do
    field :id, :id
    field :schedule, :order_schedule
    field :customer_number, :integer
    field :ordered_at, :datetime
    field :state, :order_state
    field :items, list_of(:order_item), resolve: assoc(:items)
  end

  object :order_item do
    field :id, :id
    field :price, :decimal
    field :state, :order_state
    field :quantity, :integer
    field :menu_item, :menu_item, resolve: assoc(:menu_item)
  end

  enum :order_schedule do
    value :rush, as: "rush"
    value :priority, as: "priority"
    value :normal, as: "normal"
  end

  enum :order_state do
    value :created, as: "created"
    value :completed, as: "completed"
  end
end
