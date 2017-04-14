defmodule Ex do
  @moduledoc """
  Documentation for Ex.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Ex.hello
      :world

  """
  def hello do
    :world
  end

  @doc """
  Shoots a new door with the given `color`.
  """
  def shoot(color) do
    Supervisor.start_child(Portal.Supervisor, [color])
  end
end

defmodule Ex do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: :chat_supervisor)
  end

  def start_room(name) do
    Supervisor.start_child(:chat_supervisor, [name])
  end

  def init(_) do
    children = [
      worker(Chat.Server, [])
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
