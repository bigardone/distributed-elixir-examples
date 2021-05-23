defmodule SimpleCluster do
  defdelegate ping, to: SimpleCluster.Ping
end
