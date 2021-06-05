defmodule HordeBackgroundJobTest do
  use ExUnit.Case
  doctest HordeBackgroundJob

  test "greets the world" do
    assert HordeBackgroundJob.hello() == :world
  end
end
