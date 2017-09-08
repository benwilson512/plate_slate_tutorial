# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :plate_slate,
  ecto_repos: [PlateSlate.Repo],
  order_item_time: 5_000,
  order_completion_time: 20_000

# Configures the endpoint
config :plate_slate, PlateSlateWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OneaCdQNDTY23TjM9aOMUuExzbv1ONa4ahvIn+0tVWir5G9DDVoqZ9FvzavC/y47",
  render_errors: [view: PlateSlateWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: PlateSlate.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
