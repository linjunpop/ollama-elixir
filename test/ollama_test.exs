defmodule OllamaTest do
  use ExUnit.Case
  doctest Ollama

  describe "stream_response/2" do
    test "run llama" do
      Finch.start_link(name: OllamaFinch)
      ollama = Ollama.new("http://localhost:11434", OllamaFinch)

      params = %{
        model: "zephyr:latest",
        prompt: "You are a helpful assistant",
        context: [],
        format: :json,
        options: %{
          temperature: 0.0
        }
      }

      {:ok, result} =
        Ollama.generate(ollama, params, fn
          {:chunk, chunk} ->
            assert %Ollama.Chunk{} = chunk

          :done ->
            nil
        end)

      assert result.model == "zephyr:latest"
      refute Enum.empty?(result.context)
      assert result.meta.total_duration
    end
  end
end
