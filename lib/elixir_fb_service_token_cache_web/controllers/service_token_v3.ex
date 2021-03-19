defmodule ElixirFbServiceTokenCacheWeb.ServiceTokenV3 do
  use ElixirFbServiceTokenCacheWeb, :controller

  def index(conn, %{"application" => application, "namespace" => namespace}) do
    key = "encoded-public-key-#{application}"
    {:ok, cached_value } = Redix.command(:redix, ["GET", key])

    public_key = if cached_value do
      IO.puts("HIT CACHE")
      cached_value
    else
      IO.puts("MISS CACHE")
      command = [
        "get",
        "configmaps",
        "-o",
        "jsonpath='{.data.ENCODED_PUBLIC_KEY}'",
        "fb-#{application}-config-map",
        "-n",
        "#{namespace}"
      ]
      {config_map, 0} = System.cmd(
        "kubectl",
        command
      )
      Redix.command(:redix, ["SET", key, config_map])
      config_map
    end

    json(conn, %{token: public_key})
  end
end
