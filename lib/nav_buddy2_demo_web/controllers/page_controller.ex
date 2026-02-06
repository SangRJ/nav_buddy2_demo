defmodule NavBuddy2DemoWeb.PageController do
  use NavBuddy2DemoWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
