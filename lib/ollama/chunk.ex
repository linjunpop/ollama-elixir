defmodule Ollama.Chunk do
  # {
  #   "model": "llama2",
  #   "created_at": "2023-08-04T08:52:19.385406455-07:00",
  #   "response": "The",
  #   "done": false
  # }
  defstruct [:model, :created_at, :response]
end
