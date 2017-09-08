defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  import_types __MODULE__.MenuTypes
  import_types __MODULE__.OrderingTypes
  import_types Absinthe.Type.Custom

  alias PlateSlateWeb.Resolvers

  query do
    field :menu_items, list_of(:menu_item) do
      arg :filter, :menu_items_filter
      arg :order, :sort_order, default_value: :asc
      resolve &Resolvers.Menu.menu_items/3
    end

    field :orders, list_of(:order) do
      arg :state, :order_state
      resolve &Resolvers.Ordering.orders/3
    end
  end

  mutation do
    field :place_order, :order do
      arg :items, non_null(list_of(non_null(:place_order_input)))

      resolve &Resolvers.Ordering.place_order/3
    end
  end

  subscription do
    field :order_placed, :order do
      config fn _, _ ->
        {:ok, topic: "*"}
      end

      trigger :place_order, topic: fn _order ->
        "*"
      end
    end

    field :order_completed, :order do
      config fn _, _ ->
        {:ok, topic: "*"}
      end
    end
    field :order_item_completed, :order_item do
      config fn _, _ ->
        {:ok, topic: "*"}
      end
    end
  end

  enum :sort_order do
    value :asc
    value :desc
  end
end
