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

  @query """
  query ($term: String) {
    menuItems(matching:$term) { name}
  }
  """
  test "list menu items with filter and variables" do
    variables = %{"term" => "Rue"}
    conn = get build_conn(), "/", query: @query, variables: variables

    assert %{"data" => %{"menuItems" => [item] }} = json_response(conn, 200)
    assert item == %{"name" => "Rueben"}
  end

  test "list menu items with filter + variables + POST" do
    variables = %{"term" => "Rue"}
    conn =
      build_conn()
      |> Plug.Conn.put_req_header("content-type", "application/json")
      |> post("/", %{"query" => @query, "variables" => variables})

    assert %{"data" => %{"menuItems" => [item] }} = json_response(conn, 200)
    assert item == %{"name" => "Rueben"}
  end

  test "list menu items without filter with POST" do
    query = "{ menuItems { name } }"
    conn =
      build_conn()
      |> Plug.Conn.put_req_header("content-type", "application/json")
      |> post("/", %{"query" => query})

    assert %{"data" => %{"menuItems" => [item |_] }} = json_response(conn, 200)
    assert item == %{"name" => "Rueben"}
  end

  test "list menu items with filter" do
    query = "{ menuItems(matching: \"Rue\") { name } }"
    conn =
      build_conn()
      |> Plug.Conn.put_req_header("content-type", "application/json")
      |> post("/", %{"query" => query})

    assert %{"data" => %{"menuItems" => [item] }} = json_response(conn, 200)
    assert item == %{"name" => "Rueben"}
  end
end
