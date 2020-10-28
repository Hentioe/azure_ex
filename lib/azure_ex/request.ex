defmodule AzureEx.Request do
  @moduledoc """
  HTTP request functions.
  """

  alias AzureEx.{Config, TokenHosting}

  @type method :: :get | :post
  @type data :: map
  @type result :: any
  @type error :: any
  @type httpoison_result :: {:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Error.t()}

  @spec call(binary, method, data) :: {:ok, result} | {:error, error}
  def call(endpoint, method, body \\ %{}) do
    method |> send(endpoint, body) |> handle_response()
  end

  @spec handle_response({:ok, HTTPoison.Response.t()}) :: {:ok, result} | {:error, error}
  def handle_response({:ok, %HTTPoison.Response{body: body, status_code: status_code}}) do
    if body == "" do
      {:ok, status_code}
    else
      {:ok, Jason.decode!(body, keys: :atoms)}
    end
  end

  @spec send(method, String.t(), data) :: httpoison_result
  defp send(:get, endpoint, _data) do
    headers = [Authorization: "Bearer #{TokenHosting.get_token()}"]

    HTTPoison.get(endpoint, headers, Config.timeouts())
  end

  defp send(:post, endpoint, data) do
    headers = [
      Authorization: "Bearer #{TokenHosting.get_token()}",
      "Content-Type": "application/json"
    ]

    body = Jason.encode!(data || %{})

    HTTPoison.post(endpoint, body, headers, Config.timeouts())
  end
end
