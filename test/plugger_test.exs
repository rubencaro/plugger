defmodule PluggerTest do
  use ExUnit.Case
  use Plug.Test

  @opts Plugger.Web.Router.init([])

  test "greets the world" do
    assert Plugger.hello() == :world
  end

  test "returns hello world" do
    # Create a test connection
    conn = conn(:get, "/hello")

    # Invoke the plug
    conn = Plugger.Web.Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "world"
  end
end
