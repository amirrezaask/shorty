defmodule Shorty do
  use Application

  def start(_, _) do
    children = [
      {Shorty.Http.Server, name: :short_http_server}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
