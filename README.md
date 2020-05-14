# NodeCompass

NodeCompass is an automated system to control a consistent hash ring within an Elixir/Erlang cluster. It looks for node joins and leaves, then automatically controls their state on the ring. It also has some filtering options you can configure to make sure it adds the right nodes.

## Installation

Add `node_compass` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:node_compass, "~> 0.1.0"}
  ]
end
```
