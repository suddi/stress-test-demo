defmodule Ex.Server do
  require Logger

	@doc """
  Starts accepting connections on the given `port`.
  """
  def accept(port) do
    opts = [:binary, packet: :http, active: false, reuseaddr: true]
    {:ok, socket} = :gen_tcp.listen(port, opts)
    Logger.info "Accepting connections on port #{port}"
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    {:ok, pid} = Task.Supervisor.start_child(Ex.TaskSupervisor, fn -> serve(client) end)
    :ok = :gen_tcp.controlling_process(client, pid)
    loop_acceptor(socket)
  end

  defp serve(socket) do
    {:ok, req} = recv_request(socket)
    data = Ex.Route.handle_route(req)
    send_response(socket, data)
  end

  defp recv_request(socket) do
    :gen_tcp.recv(socket, 0)
  end

  defp send_response(socket, {:ok, text}) do
    response = get_response(200, text)
    :gen_tcp.send(socket, response)
    :gen_tcp.close(socket)
  end

  defp get_response(200, body) do
    status_code = "HTTP/1.1 200 OK"
    headers = [
      "Connection: close",
      "Content-Type: application/json; charset=UTF-8",
      "Cache-Control: no-cache"
    ]
    separator = "\r\n"
    output = "{\"status\":\"OK\",\"hash\":\"#{body}\"}"
    status_code <> separator <> Enum.join(headers, "\r\n") <> separator <> separator <> output
  end
end
