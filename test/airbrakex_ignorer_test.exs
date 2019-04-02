defmodule AirbrakexIgnorerTest do
  use ExUnit.Case

  defmodule SpecificError do
    defexception [:message]
  end

  def fetch_error(fun) do
    fun.()
  rescue
    e -> e
  end

  def ignore(types) do
    :ok = :airbrakex_ignorer |> Application.put_env(:types, types)
  end

  test "ignores by type" do
    ignore([SpecificError])

    specific_error = fetch_error(fn -> raise SpecificError, "ignored" end)
    another_error = fetch_error(fn -> raise "whatever" end)

    assert AirbrakexIgnorer.ignore?(specific_error)
    refute AirbrakexIgnorer.ignore?(another_error)
  end

  test "ignores by message" do
    ignore([SpookyError])
    spooky_message = ~s(I'm a spooky error, %SpookyError{message: "boo"})
    spooky_error = fetch_error(fn -> raise spooky_message end)

    another_error = fetch_error(fn -> raise "whatever SpookyError thing" end)

    assert AirbrakexIgnorer.ignore?(spooky_error)
    refute AirbrakexIgnorer.ignore?(another_error)
  end
end
