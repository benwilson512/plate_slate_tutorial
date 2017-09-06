defmodule PlateSlateWeb.Router do
  use PlateSlateWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: PlateSlateWeb.Schema,
      interface: :simple,
      socket: PlateSlateWeb.UserSocket

    forward "/", Absinthe.Plug,
      schema: PlateSlateWeb.Schema
  end
end
