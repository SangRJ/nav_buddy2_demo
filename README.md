# NavBuddy2 Demo

A showcase application for **NavBuddy2** — the permission-aware, multi-layout navigation engine for Phoenix LiveView.

![NavBuddy2 Demo](https://via.placeholder.com/800x400?text=NavBuddy2+Demo+Preview)

## Features

- **Multiple Layouts**: Seamlessly switch between **Sidebar**, **Horizontal**, and **Auto** (responsive) modes.
- **Client-Side Persistence**: Remembers your layout and sidebar state using Alpine.js + localStorage.
- **DaisyUI Theming**: Fully support for light/dark modes and custom themes.
- **Permission-Aware**: Items are automatically hidden if the user lacks the required key (e.g., `:admin`).
- **Command Palette**: Built-in `⌘K` / `Ctrl+K` searchable navigation.
- **3-Level Depth**: Supports complex hierarchies (Sidebar → Section → Item → Children).

## Getting Started

To start the demo server:

1.  Run `mix setup` to install dependencies.
2.  Start Phoenix with `mix phx.server`.

Visit [`localhost:4000`](http://localhost:4000) to see the demo in action.

## Key Components

-   **`NavBuddy2.Nav`**: The main rendering component.
-   **`NavBuddy2.Renderer.*`**: Individual renderers for Sidebar, Horizontal, and Mobile Drawer.
-   **`NavBuddy2DemoWeb.Navigation`**: Defines the navigation structure.
-   **`NavBuddy2Demo.NavPermissions`**: Handles permission logic.

## Layout Modes

| Mode | Description |
| :--- | :--- |
| **Sidebar** | Classic 2-column layout (Icon Rail + Sidebar Panel) |
| **Horizontal** | Modern top-bar navigation with dropdowns |
| **Auto** | Sidebar on desktop, Horizontal + Drawer on mobile |



## Integration Guide

This demo illustrates the following setup steps for `nav_buddy2`:

1.  **Add Dependency (`mix.exs`)**:
    ```elixir
    {:nav_buddy2, github: "SangRJ/nav_buddy2"}
    ```

2.  **Add JS Dependency (`assets/package.json`)**:
    ```json
    "nav_buddy2": "file:../deps/nav_buddy2"
    ```

3.  **Configure LiveSocket (`assets/js/app.js`)**:
    Register the Alpine plugin and configure the DOM patcher to preserve state:
    ```javascript
    import NavBuddy2Plugin from "nav_buddy2"
    Alpine.plugin(NavBuddy2Plugin)

    let liveSocket = new LiveSocket("/live", Socket, {
      // ...
      dom: {
        onBeforeElUpdated(from, to) {
          if (from._x_dataStack) {
            window.Alpine.clone(from, to)
          }
        }
      }
    })
    ```

4.  **Define Navigation (`lib/my_app_web/navigation.ex`)**:
    Create a module that returns the list of `Sidebar`, `Section`, and `Item` structs.

5.  **Add to Layout (`app.html.heex`)**:
    Wrap your main content with the `<NavBuddy2.Nav.nav>` component.

## Troubleshooting

### Content Duplication on Refresh

If you see the navigation layouts duplicating (rendering all 3 modes at once) after a page refresh or navigation:

**Cause**: Phoenix LiveView DOM patching can overwrite Alpine.js state (`_x_dataStack`), causing `x-show` directives to fail.

**Fix**: Ensure your `assets/js/app.js` configures the `LiveSocket` with the `dom` option to preserve Alpine state:

```javascript
// assets/js/app.js
let liveSocket = new LiveSocket("/live", Socket, {
  // ... other options
  dom: {
    onBeforeElUpdated(from, to) {
      if (from._x_dataStack) {
        window.Alpine.clone(from, to)
      }
    }
  }
})
```

