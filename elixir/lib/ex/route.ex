defmodule Ex.Route do
  @doc """
  Handle the route provided
  """
  def handle_route({:http_request, :GET, {:abs_path, path}, _version}) do
    [_ | input] = path
    {:ok, salt} = :bcrypt.gen_salt(10)
    :bcrypt.hashpw(input, salt)
  end
end
