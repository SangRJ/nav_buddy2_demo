defmodule NavBuddy2DemoWeb.NavBacking do
  import Phoenix.Component
  import Phoenix.LiveView

  def on_mount(:default, _params, _session, socket) do
    # In a real app, you'd fetch the user from the session
    user = %NavBuddy2Demo.User{
      id: 1,
      name: "Demo Admin",
      permissions: [:view_dashboard, :manage_users, :admin]
    }

    {:cont,
     socket
     |> assign(:current_user, user)
     |> assign_new(:nav_layout, fn -> "sidebar" end)
     |> assign_new(:nav_collapsed, fn -> false end)
     |> assign_new(:active_sidebar_id, fn -> nil end)
     |> attach_hook(:set_current_path, :handle_params, &handle_params/3)}
  end

  defp handle_params(_params, url, socket) do
    {:cont, assign(socket, :current_request_url, url)}
  end
end
