defmodule Ollama.Chunk do
  @type t ::
          %__MODULE__{
            model: String.t(),
            created_at: String.t(),
            response: String.t()
          }
  defstruct [:model, :created_at, :response]
end
