defmodule PlateSlate.Initializer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], [])
  end

  def init(state) do
    import Ecto.Query
    alias PlateSlate.{Ordering, Repo}

    Ordering.Order
    |> where([o], o.state != "completed")
    |> Repo.all
    |> Enum.map(fn order ->
      Ordering.advance(order)
    end)
    {:ok, state}
  end
end
