defmodule SwarmBackgroundJob.DatabaseCleaner.Supervisor do
  use DynamicSupervisor

  def start_link(state) do
    DynamicSupervisor.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(opts) do
    child_spec = %{
      id: SwarmBackgroundJob.DatabaseCleaner,
      start: {SwarmBackgroundJob.DatabaseCleaner, :start_link, [opts]},
      restart: :temporary
    }

    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end
end
