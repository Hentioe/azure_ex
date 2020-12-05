defmodule AzureEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :azure_ex,
      version: "0.1.0-dev",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {AzureEx.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.7"},
      {:typed_struct, "~> 0.2.1"},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:jason, "~> 1.2"},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end
end
