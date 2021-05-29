defmodule GlobalBackgroundJob.Singleton.State do
  alias __MODULE__

  @type t :: %State{
          args: keyword,
          mod: module,
          name: term,
          pid: pid
        }

  defstruct [
    :args,
    :mod,
    :name,
    :pid
  ]

  def build(opts) when is_map(opts) do
    struct!(State, opts)
  end

  def with_pid(%State{} = state, pid) do
    %{state | pid: pid}
  end
end
