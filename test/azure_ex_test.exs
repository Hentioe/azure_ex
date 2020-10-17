defmodule AzureExTest do
  use ExUnit.Case
  doctest AzureEx

  test "greets the world" do
    assert AzureEx.hello() == :world
  end
end
