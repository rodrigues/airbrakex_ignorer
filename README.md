# AirbrakexIgnorer

Very simple filtering module for ignoring [`airbrakex`](https://github.com/fazibear/airbrakex) errors.

It can filter error types, matching both exception type and the error message itself for the presence of the type.

## Installation

Add `airbrakex_ignorer` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:airbrakex_ignorer, "~> 0.1.0"}
  ]
end
```

Configure airbrakex ignore to use this package:

```elixir
config :airbrakex,
  #...
  ignore: {AirbrakexIgnorer, :ignore?, []}
```

Configure airbrakex ignorer with the types you want to ignore:

```elixir
config :airbrakex_ignorer,
  types: [
    Phoenix.Router.NoRouteError
  ]
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/airbrakex_ignorer](https://hexdocs.pm/airbrakex_ignorer).

