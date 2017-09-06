defmodule PlateSlateWeb.Router do
  use PlateSlateWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PlateSlateWeb do
    pipe_through :api
  end
end
