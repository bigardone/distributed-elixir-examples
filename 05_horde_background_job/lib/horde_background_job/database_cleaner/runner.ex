defmodule HordeBackgroundJob.DatabaseCleaner.Runner do
  @moduledoc """
  Module which fakes deleting records from a database.
  """

  require Logger

  def execute do
    random = :rand.uniform(1_000)

    Process.sleep(random)

    Logger.info("#{__MODULE__} #{random} records deleted")
  end
end
