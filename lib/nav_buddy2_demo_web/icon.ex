defmodule NavBuddy2DemoWeb.NavIcon do
  use Phoenix.Component
  import NavBuddy2DemoWeb.CoreComponents

  def render(assigns) do
    ~H"""
    <.icon name={"hero-#{@name}"} class={@class} />
    """
  end
end
