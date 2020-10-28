defmodule AzureEx.Request do
  @moduledoc """
  HTTP request functions.
  """

  alias AzureEx.{Config, TokenHosting}

  @type body :: map
  @type result :: any
  @type error :: any
  @type httpoison_result :: {:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Error.t()}

  @spec call(binary, atom, body) ::
          {:ok, result} | {:error, error}
  def call(endpoint, method, body \\ %{}) do
    method |> send(endpoint, body) |> handle_response()
  end

  @spec handle_response({:ok, HTTPoison.Response.t()}) :: {:ok, result} | {:error, error}
  def handle_response({:ok, %HTTPoison.Response{body: body}}) do
    {:ok, Jason.decode!(body, keys: :atoms)}
  end

  @spec send(:get, String.t(), body) :: httpoison_result
  def send(:get, endpoint, _body \\ %{}) do
    headers = [Authorization: "Bearer #{TokenHosting.get_token()}"]

    HTTPoison.get(endpoint, headers, Config.timeouts())
  end
end
