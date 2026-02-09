defmodule NavBuddy2DemoWeb.NavIcon do
  use Phoenix.Component
  import NavBuddy2DemoWeb.CoreComponents

  attr :name, :atom, required: true
  attr :class, :string, default: nil

  def render(assigns) do
    ~H"""
    <.icon
      name={
        "hero-" <>
          (@name
           |> to_string()
           |> String.replace("_", "-"))
      }
      class={@class}
    />
    """
  end
end
