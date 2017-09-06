defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema
  # also see Absinthe.Schema.Notation

  query do
    field :health, :string
  end

  @desc """
  Tasty thing to eat!
  """
  object :menu_item do
    field :id, :id
    @desc "The name of the item"
    field :name, :string
    field :description, :string
  end
end
