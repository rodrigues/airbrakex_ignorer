defmodule AirbrakexIgnorer do
  @moduledoc "Filters error types that airbrake should ignore"

  @spec ignore?(map) :: boolean
  def ignore?(error) when is_map(error) do
    error_type_ignore?(error) || error_message_ignore?(error)
  end

  @spec ignored_error_types() :: [module]
  def ignored_error_types do
    :airbrakex_ignorer |> Application.get_env(:types, [])
  end

  defp error_type_ignore?(%{type: type}) when is_atom(type) do
    ignored_error_types() |> Enum.member?(type)
  end

  defp error_type_ignore?(%{__exception__: true, __struct__: type}) when is_atom(type) do
    %{type: type} |> error_type_ignore?()
  end

  defp error_type_ignore?(_), do: false

  defp error_message_ignore?(%{message: message}) when is_binary(message) do
    ignored_error_types() |> Enum.any?(&String.contains?(message, struct_prefix(&1)))
  end

  defp error_message_ignore?(_), do: false

  defp struct_prefix(ignored_type) when is_atom(ignored_type) do
    module_name = ignored_type |> to_string |> String.replace(~r/^Elixir\./, "")
    "%#{module_name}{"
  end
end
