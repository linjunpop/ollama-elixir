defmodule Ollama.Meta do
  defstruct total_duration: nil,
            load_duration: nil,
            sample_count: nil,
            sample_duration: nil,
            prompt_eval_count: nil,
            prompt_eval_duration: nil,
            eval_count: nil,
            eval_duration: nil
end
