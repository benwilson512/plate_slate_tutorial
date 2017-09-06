defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema
  # also see Absinthe.Schema.Notation

  import Ecto.Query
  alias PlateSlateWeb.Resolvers

  query do
    field :menu_items, list_of(:menu_item) do
      arg :matching, :string
      resolve &Resolvers.Menu.menu_items/3
    end
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
