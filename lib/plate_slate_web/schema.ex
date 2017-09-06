defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema
  # also see Absinthe.Schema.Notation

  query do
    field :menu_items, list_of(:menu_item) do
      resolve fn _, _, _ ->
        schema = PlateSlate.Menu.Item
        {:ok, PlateSlate.Repo.all(schema)}
      end
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
