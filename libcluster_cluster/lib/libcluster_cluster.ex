defmodule LibclusterCluster do
  defdelegate ping, to: LibclusterCluster.Ping
end
