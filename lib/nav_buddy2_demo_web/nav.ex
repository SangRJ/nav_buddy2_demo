defmodule NavBuddy2DemoWeb.Navigation do
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
