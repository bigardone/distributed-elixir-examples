defmodule SimpleClusterTest do
  use ExUnit.Case
  doctest SimpleCluster

  test "greets the world" do
    assert SimpleCluster.hello() == :world
  end
end
