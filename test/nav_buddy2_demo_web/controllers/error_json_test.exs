defmodule NavBuddy2DemoWeb.ErrorJSONTest do
  use NavBuddy2DemoWeb.ConnCase, async: true

  test "renders 404" do
    assert NavBuddy2DemoWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert NavBuddy2DemoWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
