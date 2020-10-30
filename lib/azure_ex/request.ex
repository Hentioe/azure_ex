defmodule AzureEx.Request do
  @moduledoc """
  HTTP request functions.
  """

  alias AzureEx.{Config, TokenHosting}

  @type method :: :get | :post | :put | :delete
  @type data :: map
  @type result :: any
  @type error :: any
  @type httpoison_result :: {:ok, HTTPoison.Response.t()} | {:error, HTTPoison.Error.t()}

  @spec call(binary, method, data) :: {:ok, result} | {:error, error}
  def call(endpoint, method, data \\ %{}) do
    method |> send(endpoint, data) |> handle_response()
  end

  @spec handle_response({:ok, HTTPoison.Response.t()}) :: {:ok, result} | {:error, error}
  def handle_response({:ok, %HTTPoison.Response{body: body, status_code: status_code}}) do
    if body == "" do
      {:ok, status_code}
    else
      {:ok, Jason.decode!(body, keys: :atoms)}
    end
  end

  @data_content_type "application/json"

  @spec send(method, String.t(), data) :: httpoison_result
  defp send(:get, endpoint, _data) do
    headers = [Authorization: "Bearer #{TokenHosting.get_token()}"]

    HTTPoison.get(endpoint, headers, Config.timeouts())
  end

  defp send(:post, endpoint, data) do
    headers = [
      Authorization: "Bearer #{TokenHosting.get_token()}",
      "Content-Type": @data_content_type
    ]

    body = Jason.encode!(data || %{})

    HTTPoison.post(endpoint, body, headers, Config.timeouts())
  end

  defp send(:put, endpoint, data) do
    headers = [
      Authorization: "Bearer #{TokenHosting.get_token()}",
      "Content-Type": @data_content_type
    ]

    body = Jason.encode!(data || %{})

    HTTPoison.put(endpoint, body, headers, Config.timeouts())
  end

  defp send(:delete, endpoint, _data) do
    headers = [Authorization: "Bearer #{TokenHosting.get_token()}"]

    HTTPoison.delete(endpoint, headers, Config.timeouts())
  end
end
