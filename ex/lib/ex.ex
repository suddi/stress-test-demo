defmodule Ex do
  use Application

  @doc false
  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Task.Supervisor, [[name: Ex.TaskSupervisor]]),
      worker(Task, [Ex.Server, :accept, [3001]])
    ]

    opts = [strategy: :one_for_one, name: Ex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
