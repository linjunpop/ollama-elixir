defmodule Ollama.Meta do
  @type t ::
          %__MODULE__{
            total_duration: String.t(),
            load_duration: String.t(),
            sample_count: String.t(),
            sample_duration: String.t(),
            prompt_eval_count: String.t(),
            prompt_eval_duration: String.t(),
            eval_count: String.t(),
            eval_duration: String.t()
          }
  defstruct total_duration: nil,
            load_duration: nil,
            sample_count: nil,
            sample_duration: nil,
            prompt_eval_count: nil,
            prompt_eval_duration: nil,
            eval_count: nil,
            eval_duration: nil
end
