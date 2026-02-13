defmodule NavBuddy2DemoWeb.DemoPageLive do
  use NavBuddy2DemoWeb, :live_view

  @impl true
  def mount(%{"type" => type} = _params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, String.capitalize(type))
     |> assign(:type, type)
     |> assign(:current_path, "/#{socket.assigns.live_action}/#{type}")}
  end

  @impl true
  def render(assigns) do
    ~H"""
      <div class="max-w-4xl mx-auto space-y-8">

       <div class="mt-8 flex justify-center">
          <Layouts.theme_toggle />
        </div>
        <div class="space-y-2">
          <h1 class="text-4xl font-bold">{@page_title}</h1>
          <p class="text-xl text-base-content/60">
            This is a demo page for the <strong>{@type}</strong> section.
          </p>
        </div>

        <div class="card bg-base-200 p-6">
          <h2 class="text-xl font-semibold mb-4">Current Context</h2>
          <dl class="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div>
              <dt class="text-sm text-base-content/60">Path</dt>
              <dd class="font-mono">{@current_path}</dd>
            </div>
            <div>
              <dt class="text-sm text-base-content/60">Live Action</dt>
              <dd class="font-mono">{@live_action}</dd>
            </div>
          </dl>
        </div>

        <div class="alert">
          <.icon name="hero-light-bulb" class="w-6 h-6 text-primary" />
          <span>
            Use the navigation sidebar or the command palette (⌘K) to explore other sections.
          </span>
        </div>


      </div>
    """
  end

  @impl true
  def handle_event("nav_buddy2:switch_sidebar", %{"id" => id}, socket) do
    {:noreply, assign(socket, :active_sidebar_id, String.to_existing_atom(id))}
  end
end
