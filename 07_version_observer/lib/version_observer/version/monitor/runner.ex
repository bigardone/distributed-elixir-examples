defmodule VersionObserver.Version.Monitor.Runner do
  require Logger

  alias VersionObserver.Version.Repo

  @spec run() :: {:ok, String.t()} | {:error, :invalid_nodes | :out_of_sync}
  def run do
    log("requesting version to other nodes...")

    case GenServer.multi_call(Repo, :get) do
      {nodes, []} ->
        do_check(nodes)

      {_, invalid_nodes} ->
        log("invalid nodes found: #{inspect(invalid_nodes)}")

        {:error, :invalid_nodes}
    end
  end

  defp do_check(nodes) do
    nodes
    |> Keyword.values()
    |> Enum.uniq()
    |> case do
      [{:ok, version}] ->
        log("all nodes running version #{inspect(version)}")

        {:ok, version}

      other ->
        log("nodes out of sync: #{inspect(other)}")

        {:error, :out_of_sync}
    end
  end

  defp log(text) do
    Logger.info("----[#{node()}-#{inspect(self())}] #{__MODULE__} #{text}")
  end
end
