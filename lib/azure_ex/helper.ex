defmodule AzureEx.Helper do
  @moduledoc false

  @spec build_api_version(integer, integer, integer) :: [{:"api-version", binary}]
  def build_api_version(year, month, day) do
    ["api-version": "#{year}-#{month}-#{day}"]
  end
end
