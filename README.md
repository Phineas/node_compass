# NodeCompass

NodeCompass is an automated system which controls a consistent hash ring within an Elixir/Erlang cluster. It listens for node joins and leaves, then automatically controls their state on the ring. It also has some filtering options you can configure to make sure it adds the right nodes.

## Installation

Add `node_compass` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:node_compass, "~> 0.1.0"}
  ]
end
```

## Usage

Add NodeCompass to your supervisor:

```elixir
worker(NodeCompass, [])
```

If you want to add a [node tag](#node-tags), add it to the arguments like this:

```elixir
worker(NodeCompass,, ["my_node_tag"])
```

Get a node hostname from a key:
```elixir
NodeCompass.find_node("41585599836057600")

# => {:ok, :"example@example.my.network"}
```

## Flow
![NCFlow](https://i.imgur.com/1jaLHqg.png)

## Node Tags

You can use node tags to make sure your hash ring only contains nodes you want on it. Sometimes you may be connecting Elixir nodes together that run different applications but you only want a hash ring for one application. For example, at Hiven we run 2 Elixir applications - HivenCore and HivenSwarm; all nodes are connected to each other despite being different applications, but we want individual hash rings since each application runs different workloads (swarm runs sessions, core runs houses/rooms).