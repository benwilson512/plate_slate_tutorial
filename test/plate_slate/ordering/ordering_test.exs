defmodule PlateSlate.OrderingTest do
  use PlateSlate.DataCase, async: true

  alias PlateSlate.Ordering

  setup do
    Code.load_file("priv/repo/seeds.exs")
  end

  describe "orders" do
    alias PlateSlate.Ordering.Order

    # START:test
    test "create_order/1 with valid data creates a order" do
      chai = Repo.get_by!(PlateSlate.Menu.Item, name: "Masala Chai")
      fries = Repo.get_by!(PlateSlate.Menu.Item, name: "French Fries")

      # START_HIGHLIGHT
      attrs = %{
        customer_number: 42,
        ordered_at: "2010-04-17 14:00:00.000000Z",
        state: "created",
        items: [
          %{menu_item_id: chai.id, quantity: 1},
          %{menu_item_id: fries.id, quantity: 2},
        ]
      }

      assert {:ok, %Order{} = order} = Ordering.create_order(attrs)
      order = Repo.preload(order, :items)
      assert Enum.map(order.items,
        &Map.take(&1, [:name, :quantity, :price])
      ) == [
        %{quantity: 1, price: chai.price},
        %{quantity: 2, price: fries.price},
      ]
      # END_HIGHLIGHT

      assert order.state == "created"
    end
    # END:test
  end
end
