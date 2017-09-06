defmodule PlateSlateWeb.Schema.OrderingTypes do
  use Absinthe.Schema.Notation

  object :order do
    field :customer_number, :integer
    field :ordered_at, :datetime
    field :state, :order_state
    field :items, list_of(:order_item)
  end

  object :order_item do
    field :price, :decimal
    field :quantity, :integer
  end

  enum :order_state do
    value :created
    value :completed
  end
end
