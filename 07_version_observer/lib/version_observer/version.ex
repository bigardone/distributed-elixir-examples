defmodule VersionObserver.Version do
  alias __MODULE__

  @type t :: %Version{
          major: non_neg_integer,
          minor: non_neg_integer,
          patch: non_neg_integer
        }

  defstruct major: 0, minor: 0, patch: 0

  @spec from_string(String.t()) :: {:ok, Version.t()} | {:error, :invalid_version}
  def from_string(value) do
    with [major, minor, patch] <- to_chunks(value) do
      {:ok, %Version{major: major, minor: minor, patch: patch}}
    end
  end

  @spec incompatible?(Version.t(), Version.t()) :: boolean
  def incompatible?(%Version{major: major_1}, %Version{major: major_2}), do: major_1 != major_2

  defimpl String.Chars do
    def to_string(%Version{major: major, minor: minor, patch: patch}) do
      "#{major}.#{minor}.#{patch}"
    end
  end

  defp to_chunks(value) do
    case String.split(value, ".") do
      [_major, _minor, _patch] = chunks ->
        Enum.map(chunks, &String.to_integer/1)

      _ ->
        {:error, :invalid_version}
    end
  rescue
    _ ->
      {:error, :invalid_version}
  end
end
