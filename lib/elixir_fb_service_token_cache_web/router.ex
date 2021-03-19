defmodule ElixirFbServiceTokenCacheWeb.Router do
  use ElixirFbServiceTokenCacheWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirFbServiceTokenCacheWeb do
    pipe_through :api

    get "/v3/applications/:application/namespaces/:namespace", ServiceTokenV3, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: ElixirFbServiceTokenCacheWeb.Telemetry
    end
  end
end
