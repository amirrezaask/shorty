defmodule Shorty.Http.Handlers do
  def short(url) do
    key = UUID.uuid4(:hex)
    {:ok, "OK"} = Redix.command(:Redix, ["SET", key, url])
    {:ok, key}
  end

  def expand(key) do
    Redix.command(:Redix, ["GET", key])
  end
end
