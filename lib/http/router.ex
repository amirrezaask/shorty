defmodule Shorty.Http.Router do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)

  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)

  plug(:dispatch)

  # get /short?url=?
  # get /expand?key=?

  get "/short" do
    {:ok, url} = Map.fetch(conn.query_params, "url")

    case Shorty.Http.Handlers.short(url) do
      {:ok, short_url} -> send_resp(conn, 200, Poison.encode!(%{short: short_url}))
      {:invalid_input} -> send_resp(conn, 400, "Bad Request")
      {:internal_error} -> send_resp(conn, 500, "Internal Server Error")
    end
  end

  get "/expand" do
    {:ok, key} = Map.fetch(conn.query_params, "key")

    case Shorty.Http.Handlers.expand(key) do
      {:ok, url} -> send_resp(conn, 200, Poison.encode!(%{url: url}))
      {:invalid_input} -> send_resp(conn, 400, "Bad Request")
      {:internal_error} -> send_resp(conn, 500, "Internal Server Error")
    end
  end
end
