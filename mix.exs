defmodule Plugger.MixProject do
  use Mix.Project

  def project do
    [
      app: :plugger,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: [test: ["test", "credo --strict"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Plugger.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:plug, "~> 1.0"},
      {:prometheus_plugs, "~> 1.1.5"},
      {:prometheus_ex, "~> 3.0"},
      {:observer_cli, "~> 1.4"},
      {:distillery, "~> 2.0"},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
