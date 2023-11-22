defmodule Ollama.Result do
  # {
  #   "model": "llama2",
  #   "created_at": "2023-08-04T19:22:45.499127Z",
  #   "response": "",
  #   "context": [1, 2, 3],
  #   "done": true,
  #   "total_duration": 5589157167,
  #   "load_duration": 3013701500,
  #   "sample_count": 114,
  #   "sample_duration": 81442000,
  #   "prompt_eval_count": 46,
  #   "prompt_eval_duration": 1160282000,
  #   "eval_count": 113,
  #   "eval_duration": 1325948000
  # }

  alias Ollama.Meta

  defstruct model: nil,
            created_at: nil,
            response: "",
            context: [],
            meta: %Meta{}
end
