defmodule Plugger.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy2.child_spec(
        scheme: :http,
        plug: Plugger.Web.Router,
        options: [port: 4001]
      )
    ]

    opts = [strategy: :one_for_one, name: Plugger.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
