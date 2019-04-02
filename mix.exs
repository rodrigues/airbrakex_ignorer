defmodule AirbrakexIgnorer.MixProject do
  use Mix.Project

  def project do
    [
      app: :airbrakex_ignorer,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: dialyzer(),
      docs: docs(),
      package: package(),
      source_url: "https://github.com/rodrigues/airbrakex_ignorer",
      homepage_url: "https://hexdocs.pm/airbrakex_ignorer",
      description: "Simple filtering module for airbrakex errors"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.19.1", only: :dev, runtime: false},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.4", only: [:dev, :test], runtime: false}
    ]
  end

  defp dialyzer do
    [
      plt_add_deps: :apps_direct,
      flags: ~w(
        error_handling
        race_conditions
        unmatched_returns
        underspecs
      )a
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end

  defp package do
    [
      maintainers: ["Victor Rodrigues"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/rodrigues/airbrakex_ignorer"}
    ]
  end
end
