defmodule NodeCompassTest do
  use ExUnit.Case
  doctest NodeCompass

  test "greets the world" do
    assert NodeCompass.hello() == :world
  end
end
