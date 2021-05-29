defmodule SwarmBackgroundJob.MixProject do
  use Mix.Project

  def project do
    [
      app: :swarm_background_job,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {SwarmBackgroundJob.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:libcluster, "~> 3.3"},
      {:swarm, "~> 3.4"}
    ]
  end
end
