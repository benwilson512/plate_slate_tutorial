defmodule PlateSlateWeb.Query.MenuItemsTest do
  use PlateSlateWeb.ConnCase

  setup do
    Code.eval_file("priv/repo/seeds.exs")
    :ok
  end

  test "list menu items without filter" do
    query = """
    {
      menuItems { name }
    }
    """
    conn = get build_conn(), "/", query: query

    assert %{"data" => %{"menuItems" => [item |_] }} = json_response(conn, 200)
    assert item == %{"name" => "Rueben"}
  end
end
