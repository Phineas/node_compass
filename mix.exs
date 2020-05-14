defmodule NodeCompass.MixProject do
  use Mix.Project

  def project do
    [
      app: :node_compass,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_hash_ring, "~> 3.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp package do
    [
      name: :node_compass,
      description: "NodeCompass is an automated hash-ring management system for Elixir clusters",
      maintainers: ["Hiven", "phineas"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/hivenapp/node_compass"
      }
    ]
  end
end
