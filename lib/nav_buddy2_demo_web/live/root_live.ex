defmodule NavBuddy2DemoWeb.RootLive do
  use NavBuddy2DemoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    user = %NavBuddy2Demo.User{
      id: 1,
      name: "Demo Admin",
      permissions: [:view_dashboard, :manage_users, :admin]
    }

    code_example = """
    defmodule MyAppWeb.Navigation do
      alias NavBuddy2.{Sidebar, Section, Item}

      def sidebars do
        [
          %Sidebar{
            id: :home,
            title: "Home",
            icon: :home,
            position: :top,
            sections: [
              %Section{
                title: "Overview",
                items: [
                  %Item{label: "Dashboard", icon: :squares_2x2, to: "/", exact: true},
                  %Item{
                    label: "Projects",
                    icon: :folder,
                    children: [
                      %Item{label: "Active", to: "/projects/active"},
                      %Item{label: "Archived", to: "/projects/archived"}
                    ]
                  }
                ]
              }
            ]
          },
          %Sidebar{
            id: :settings,
            title: "Settings",
            icon: :cog_6_tooth,
            position: :bottom,
            permission: :admin,
            sections: [
              %Section{
                title: "Account",
                items: [
                  %Item{label: "Profile", icon: :user, to: "/settings/profile"},
                  %Item{label: "Security", icon: :shield_check, to: "/settings/security"}
                ]
              }
            ]
          }
        ]
      end
    end
    """

    {:ok,
     socket
     |> assign(:current_user, user)
     |> assign(:nav_layout, "sidebar")
     |> assign(:nav_collapsed, false)
     |> assign(:current_path, "/")
     |> assign(:code_example, code_example)}
  end

  @impl true
  def handle_event("nav_buddy2:switch_sidebar", %{"id" => id}, socket) do
    {:noreply, assign(socket, :active_sidebar_id, String.to_existing_atom(id))}
  end

  @impl true

  def render(assigns) do
    ~H"""
    <Layouts.with_nav
      current_user={@current_user}
      current_path={@current_path}
      nav_layout={@nav_layout}
      nav_collapsed={@nav_collapsed}
    >
      <div class="max-w-4xl mx-auto space-y-12">
        <%!-- Hero Section --%>
        <div class="text-center space-y-4 py-12">
          <h1 class="text-5xl font-bold bg-gradient-to-r from-purple-600 to-blue-500 bg-clip-text text-transparent">
            NavBuddy2
          </h1>
          
          <p class="text-2xl text-base-content/70">
            Permission-aware, multi-layout navigation engine for Phoenix LiveView.
          </p>
          
          <p class="text-lg text-base-content/60 max-w-2xl mx-auto">
            One navigation tree → multiple renderers → full daisyUI theming → Alpine.js animations.
          </p>
        </div>
         <%!-- Features Grid --%>
        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          <div class="card bg-base-200 p-6 space-y-3">
            <div class="flex items-center gap-3">
              <div class="p-2 bg-purple-500/10 rounded-lg">
                <.icon name="hero-view-columns" class="w-6 h-6 text-purple-500" />
              </div>
              
              <h3 class="text-xl font-semibold">Two-Level Sidebar</h3>
            </div>
            
            <p class="text-base-content/70">
              Icon rail + collapsible detail panel. Navigate with style, just like modern React apps.
            </p>
          </div>
          
          <div class="card bg-base-200 p-6 space-y-3">
            <div class="flex items-center gap-3">
              <div class="p-2 bg-blue-500/10 rounded-lg">
                <.icon name="hero-bars-3" class="w-6 h-6 text-blue-500" />
              </div>
              
              <h3 class="text-xl font-semibold">Horizontal Navbar</h3>
            </div>
            
            <p class="text-base-content/70">
              Top navigation bar with dropdown menus. Switch layouts on the fly with the bottom-right toggle.
            </p>
          </div>
          
          <div class="card bg-base-200 p-6 space-y-3">
            <div class="flex items-center gap-3">
              <div class="p-2 bg-green-500/10 rounded-lg">
                <.icon name="hero-device-phone-mobile" class="w-6 h-6 text-green-500" />
              </div>
              
              <h3 class="text-xl font-semibold">Mobile Drawer</h3>
            </div>
            
            <p class="text-base-content/70">
              Slide-out navigation for small screens. Responsive by default with auto layout mode.
            </p>
          </div>
          
          <div class="card bg-base-200 p-6 space-y-3">
            <div class="flex items-center gap-3">
              <div class="p-2 bg-orange-500/10 rounded-lg">
                <.icon name="hero-command-line" class="w-6 h-6 text-orange-500" />
              </div>
              
              <h3 class="text-xl font-semibold">Command Palette</h3>
            </div>
            
            <p class="text-base-content/70">
              ⌘K / Ctrl+K searchable overlay. Find and navigate anywhere instantly.
            </p>
          </div>
          
          <div class="card bg-base-200 p-6 space-y-3">
            <div class="flex items-center gap-3">
              <div class="p-2 bg-red-500/10 rounded-lg">
                <.icon name="hero-shield-check" class="w-6 h-6 text-red-500" />
              </div>
              
              <h3 class="text-xl font-semibold">Permission-Aware</h3>
            </div>
            
            <p class="text-base-content/70">
              Items hidden from unauthorized users. Define permissions at sidebar, section, or item levels.
            </p>
          </div>
          
          <div class="card bg-base-200 p-6 space-y-3">
            <div class="flex items-center gap-3">
              <div class="p-2 bg-indigo-500/10 rounded-lg">
                <.icon name="hero-sparkles" class="w-6 h-6 text-indigo-500" />
              </div>
              
              <h3 class="text-xl font-semibold">3-Level Depth</h3>
            </div>
            
            <p class="text-base-content/70">
              Sidebar → Section → Item with optional children. Organize complex navigation hierarchies with ease.
            </p>
          </div>
        </div>
         <%!-- Demo Section --%>
        <div class="card bg-base-200 p-8 space-y-4">
          <h2 class="text-2xl font-bold">Try It Out</h2>
          
          <p class="text-base-content/70">Explore the navigation on the left! This demo showcases:</p>
          
          <ul class="list-disc list-inside space-y-2 text-base-content/70 ml-4">
            <li>
              <strong>Home sidebar</strong>
              with Dashboard and Projects (with nested Active/Archived items)
            </li>
            
            <li>
              <strong>Settings sidebar</strong> with Profile and Security (requires admin permission)
            </li>
            
            <li>
              <strong>Layout switcher</strong>
              in the bottom-right corner (try Sidebar, Horizontal, or Auto)
            </li>
            
            <li><strong>Command palette</strong> – press ⌘K (Mac) or Ctrl+K (Windows) to search</li>
            
            <li>
              <strong>Permission-based visibility</strong>
              – Settings is visible because you have admin rights
            </li>
          </ul>
          
          <div class="alert alert-info">
            <.icon name="hero-information-circle" class="w-5 h-5" />
            <span>
              Current user: <strong>{@current_user.name}</strong>
              with permissions:
              <code class="ml-2 px-2 py-1 bg-base-300 rounded">
                {Enum.join(@current_user.permissions, ", ")}
              </code>
            </span>
          </div>
        </div>
         <%!-- Code Example --%>
        <div class="space-y-4">
          <h2 class="text-2xl font-bold">Quick Start</h2>
           <%!-- IDE Window --%>
          <div class="rounded-lg overflow-hidden shadow-2xl border border-base-300">
            <%!-- Title Bar --%>
            <div class="bg-base-300 px-4 py-3 flex items-center justify-between border-b border-base-content/10">
              <div class="flex items-center gap-3">
                <div class="flex gap-2">
                  <div class="w-3 h-3 rounded-full bg-error"></div>
                  
                  <div class="w-3 h-3 rounded-full bg-warning"></div>
                  
                  <div class="w-3 h-3 rounded-full bg-success"></div>
                </div>
                
                <div class="flex items-center gap-2 text-sm">
                  <.icon name="hero-document-text" class="w-4 h-4 text-primary" />
                  <span class="font-medium">navigation.ex</span>
                </div>
              </div>
              
              <div class="text-xs text-base-content/60">lib/my_app_web/navigation.ex</div>
            </div>
             <%!-- Code Content --%>
            <div class="bg-base-100 overflow-x-auto">
              <pre class="overflow-x-auto p-6 text-sm leading-normal font-mono"><code>{@code_example}</code></pre>
            </div>
             <%!-- Status Bar --%>
            <div class="bg-base-300 px-4 py-2 flex items-center justify-between text-xs border-t border-base-content/10">
              <div class="flex items-center gap-4">
                <span class="flex items-center gap-1">
                  <.icon name="hero-check-circle" class="w-3 h-3 text-success" /> <span>Elixir</span>
                </span> <span class="text-base-content/60">UTF-8</span>
              </div>
              
              <div class="flex items-center gap-4 text-base-content/60">
                <span>Ln 4, Col 7</span> <span>46 lines</span>
              </div>
            </div>
          </div>
        </div>
         <%!-- Features Comparison --%>
        <div class="card bg-base-200 p-8 space-y-4">
          <h2 class="text-2xl font-bold">NavBuddy2 vs NavBuddy v1</h2>
          
          <div class="overflow-x-auto">
            <table class="table">
              <thead>
                <tr>
                  <th>Feature</th>
                  
                  <th>v1</th>
                  
                  <th>v2</th>
                </tr>
              </thead>
              
              <tbody>
                <tr>
                  <td>daisyUI support</td>
                  
                  <td>❌</td>
                  
                  <td>✅</td>
                </tr>
                
                <tr>
                  <td>Multiple layouts</td>
                  
                  <td>❌</td>
                  
                  <td>✅ sidebar, horizontal, auto</td>
                </tr>
                
                <tr>
                  <td>Layout persistence</td>
                  
                  <td>❌</td>
                  
                  <td>✅ localStorage</td>
                </tr>
                
                <tr>
                  <td>Command palette</td>
                  
                  <td>❌</td>
                  
                  <td>✅ ⌘K</td>
                </tr>
                
                <tr>
                  <td>Mobile drawer</td>
                  
                  <td>❌</td>
                  
                  <td>✅</td>
                </tr>
                
                <tr>
                  <td>3-level depth</td>
                  
                  <td>❌</td>
                  
                  <td>✅</td>
                </tr>
                
                <tr>
                  <td>Permission support</td>
                  
                  <td>Basic</td>
                  
                  <td>✅ Full (sidebar, section, item)</td>
                </tr>
                
                <tr>
                  <td>Alpine.js animations</td>
                  
                  <td>❌</td>
                  
                  <td>✅</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
         <%!-- Footer CTA --%>
        <div class="text-center py-8 flex gap-4 justify-center flex-wrap">
          <a
            href="https://hexdocs.pm/nav_buddy2"
            class="btn btn-primary btn-lg gap-2"
            target="_blank"
            rel="noopener noreferrer"
          >
            <.icon name="hero-book-open" class="w-5 h-5" /> Read the Docs
          </a>
          <a
            href="https://hex.pm/packages/nav_buddy2"
            class="btn btn-outline btn-lg gap-2"
            target="_blank"
            rel="noopener noreferrer"
          >
            <.icon name="hero-cube" class="w-5 h-5" /> View on Hex.pm
          </a>
        </div>
      </div>
    </Layouts.with_nav>
    """
  end
end
