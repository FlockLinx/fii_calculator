# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :fii_calculator, FiiCalculatorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BIN3v+1DKSc5F/jrpZbYWK3Q2JPrE8X3FUMuPVsTI3sCNHt48ZScn0FY1LyOSWG9",
  render_errors: [view: FiiCalculatorWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: FiiCalculator.PubSub,
  live_view: [signing_salt: "X8PHYHxn"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
