defmodule Shorty.Http.Server do
  use Application

  def start(_, _) do
    children = [
      {Redix, name: :Redix},
      Plug.Cowboy.child_spec(scheme: :http, plug: Shorty.Http.Router, options: [port: 8080])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
