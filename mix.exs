defmodule AzureEx.MixProject do
  use Mix.Project

  @version "0.1.0-rc.0"
  @description "Azure API client"

  def project do
    [
      app: :azure_ex,
      version: @version,
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: @description,
      package: package(),
      name: "AzureEx",
      source_url: "https://github.com/Hentioe/azure_ex",
      docs: [
        # The main page in the docs
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Hentioe/azure_ex"}
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
      {:ex_doc, "~> 0.23.0"},
      {:httpoison, "~> 1.7"},
      {:typed_struct, "~> 0.2.1"},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:jason, "~> 1.2"},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end
end
