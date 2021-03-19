# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_fb_service_token_cache,
  generators: [binary_id: true]

# Configures the endpoint
config :elixir_fb_service_token_cache, ElixirFbServiceTokenCacheWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "esrlNGX6tWI+qqWx9VuJH7mO3CADiwcgj2SgGLoTLQwu3mEOx40vX+RPgPapwXgA",
  render_errors: [view: ElixirFbServiceTokenCacheWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ElixirFbServiceTokenCache.PubSub,
  live_view: [signing_salt: "rnuJuzWE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
