defmodule NodeCompass do
  use GenServer

  require Logger
  alias ExHashRing.HashRing

  defstruct [
    :ring_pid,
    :verify_node_tag
  ]

  @spec find_node(binary | integer) :: {:ok, binary} | {:error, atom}
  def find_node(key) do
    HashRing.ETS.find_node(:compass_ring, key)
  end


  def verify_node(ext_pid, remote_tag) do
    tag = GenServer.call(:node_compass, {:get_verify_tag})

    with tag <- remote_tag do
      GenServer.cast(ext_pid, {:add_node, node()})
    end
  end

  @doc """
  Start the node_compass controller.
  NodeCompass should be run under a supervision tree, it is not recommended to call this directly.
  """
  def start_link(verify_node_tag \\ nil) do
    GenServer.start_link(__MODULE__, %__MODULE__{verify_node_tag: verify_node_tag}, name: :node_compass)
  end

  def init(state) do
    {:ok, pid} = HashRing.ETS.start_link(:compass_ring)

    pid
    |> HashRing.ETS.add_node(node())

    :net_kernel.monitor_nodes(true)

    {:ok, %__MODULE__{state | ring_pid: pid}}
  end

  def handle_call({:get_verify_tag}, _from, state) do
    {:reply, state.verify_node_tag, state}
  end

  def handle_cast({:add_node, remote_node}, state) do
    state.ring_pid
    |> HashRing.ETS.add_node(remote_node)

    Logger.info("Node added to hash ring: #{remote_node}")
    {:noreply, state}
  end

  def handle_info({:nodeup, remote_node}, state) do
    case state.verify_node_tag do
      nil ->
        GenServer.cast(self(), {:add_node, node})
      _ ->
        Node.spawn(remote_node, NodeCompass, :verify_node, [self(), state.verify_node_tag])
    end

    {:noreply, state}
  end

  def handle_info({:nodedown, node}, state) do
    state.ring_pid
    |> HashRing.ETS.remove_node(node)

    {:noreply, state}
  end
end
