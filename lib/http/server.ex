defmodule Shorty.Http.Server do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(_) do
    children = [
      {Redix, name: :Redix},
      Plug.Cowboy.child_spec(scheme: :http, plug: Shorty.Http.Router, options: [port: 8080])
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
