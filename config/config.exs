# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fily,
  ecto_repos: [Fily.Repo]

# Configures the endpoint
config :fily, FilyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zkuSKae/iv0iREVR9UEQumpRxWKvdXTHdIvAI7tk6M9NAio/Mj31jPxgAUDapWET",
  render_errors: [view: FilyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Fily.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
