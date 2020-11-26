defmodule AzureEx.Model do
  @moduledoc false

  defmodule ApiError do
    @moduledoc false

    defstruct [:code, :message]

    @type t :: %__MODULE__{
            code: String.t(),
            message: String.t()
          }
  end

  defmodule RequestError do
    @moduledoc false

    defstruct [:reason]

    @type t :: %__MODULE__{
            reason: atom()
          }
  end
end
