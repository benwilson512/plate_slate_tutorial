defmodule PlateSlateWeb.Schema.MenuTypes do
  use Absinthe.Schema.Notation

  input_object :menu_items_filter do
    field :matching, :string
    field :priced_above, :decimal
    field :priced_below, :decimal
  end

  @desc """
  Tasty thing to eat!
  """
  object :menu_item do
    field :id, :id
    @desc "The name of the item"
    field :name, :string
    field :description, :string
    field :price, :float
  end
end
