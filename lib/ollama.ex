defmodule Ollama do
  @moduledoc """
  Documentation for `Ollama`.
  """

  alias Ollama.Chunk
  alias Ollama.Result
  alias Ollama.Meta
  alias Ollama.Error

  defstruct [:host, :finch]

  def new(host, finch) do
    %__MODULE__{
      host: host,
      finch: finch
    }
  end

  def generate(
        %__MODULE__{host: host, finch: finch} = _ollama,
        params \\ %{},
        http_options \\ [receive_timeout: 30_000],
        fun
      ) do
    payload = params |> Jason.encode!()

    process_fn = fn
      {:status, _status}, acc ->
        acc

      {:headers, _headers}, acc ->
        acc

      {:data, json_string}, acc ->
        data = Jason.decode!(json_string)
        process_chunk(data, acc, fun)
    end

    Finch.build(
      :post,
      Path.join(host, "/api/generate"),
      [{"content-type", "application/json"}],
      payload
    )
    |> Finch.stream(finch, %Result{}, process_fn, http_options)
  end

  defp process_chunk(
         %{"response" => first_chunk, "done" => false} = chunk_data,
         %Result{response: ""},
         fun
       ) do
    chunk = struct(Chunk, chunk_data)

    fun.({:chunk, chunk})

    %Result{response: first_chunk}
  end

  defp process_chunk(
         %{
           "response" => new_content,
           "done" => false
         } = chunk_data,
         %Result{response: content},
         fun
       ) do
    chunk = build_chunk_struct(chunk_data)

    fun.({:chunk, chunk})

    %Result{response: content <> new_content}
  end

  defp process_chunk(
         %{"done" => true, "model" => model, "created_at" => created_at, "context" => context} =
           data,
         %Result{response: content},
         fun
       ) do
    meta = build_meta_struct(data)

    result =
      %Result{
        response: content,
        model: model,
        created_at: created_at,
        context: context,
        meta: meta
      }

    fun.(:done)

    result
  end

  defp process_chunk(%{"error" => error_message}, %Result{} = _result, fun) do
    error = %Error{message: error_message}

    fun.({:error, error})

    error
  end

  defp build_chunk_struct(%{
         "model" => model,
         "created_at" => created_at,
         "response" => response,
         "done" => false
       }) do
    struct(Chunk, model: model, created_at: created_at, response: response)
  end

  defp build_meta_struct(data) do
    struct(Meta,
      total_duration: Map.get(data, "total_duration"),
      load_duration: Map.get(data, "load_duration"),
      sample_count: Map.get(data, "sample_count"),
      sample_duration: Map.get(data, "sample_duration"),
      prompt_eval_count: Map.get(data, "prompt_eval_count"),
      prompt_eval_duration: Map.get(data, "prompt_eval_duration"),
      eval_count: Map.get(data, "eval_count"),
      eval_duration: Map.get(data, "eval_duration")
    )
  end
end
