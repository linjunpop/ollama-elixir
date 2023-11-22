defmodule Ollama.Result do
  alias Ollama.Meta

  @type t ::
          %__MODULE__{
            model: String.t(),
            created_at: String.t(),
            response: String.t(),
            context: list(),
            meta: Meta.t()
          }
  defstruct model: nil,
            created_at: nil,
            response: "",
            context: [],
            meta: %Meta{}
end
