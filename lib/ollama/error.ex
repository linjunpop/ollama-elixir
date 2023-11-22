defmodule Ollama.Error do
  @type t ::
          %__MODULE__{
            message: String.t()
          }
  defstruct [:message]
end
