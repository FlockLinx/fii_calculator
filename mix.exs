defmodule FiiCalculator.MixProject do
  use Mix.Project

  def project do
    [
      app: :fii_calculator,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {FiiCalculator.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

    defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["FlockLinx"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/FlockLinx/fii_calculator"}
    ]
  end

  defp description do
    """
    Fii search tool
    """
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.7.7"},
      {:phoenix_html, "~> 3.3.2"},
      {:phoenix_view, "~> 2.0"},
      {:phoenix_live_reload, "~> 1.3", only: :dev},
      {:phoenix_live_dashboard, "~> 0.7"},
      {:gettext, "~> 0.11"},
      {:plug_cowboy, "~> 2.0"},
      {:httpoison, "~> 2.0"},
      {:floki, "~> 0.34.0"},
      {:jason, "~> 1.4"},
      {:money, "~> 1.12"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "cmd npm install --prefix assets"],
      "assets.deploy": [
        "phx.digest"
      ]
    ]
  end
end
