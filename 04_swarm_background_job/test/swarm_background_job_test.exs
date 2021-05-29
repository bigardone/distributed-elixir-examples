defmodule SwarmBackgroundJobTest do
  use ExUnit.Case
  doctest SwarmBackgroundJob

  test "greets the world" do
    assert SwarmBackgroundJob.hello() == :world
  end
end
