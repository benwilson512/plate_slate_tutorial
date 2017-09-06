defmodule PlateSlateWeb.Schema.OrderingTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: PlateSlate.Repo

  input_object :place_order_input do
    field :quantity, non_null(:integer)
    field :menu_item_id, non_null(:id)
  end

  object :order do
    field :customer_number, :integer
    field :ordered_at, :datetime
    field :state, :order_state
    field :items, list_of(:order_item), resolve: assoc(:items)
  end

  object :order_item do
    field :price, :decimal
    field :quantity, :integer
    field :menu_item, :menu_item, resolve: assoc(:menu_item)
  end

  enum :order_state do
    value :created
    value :completed
  end
end
