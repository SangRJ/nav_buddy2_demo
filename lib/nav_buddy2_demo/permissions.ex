defmodule NavBuddy2Demo.NavPermissions do
  @behaviour NavBuddy2.PermissionResolver

  @impl true
  def can?(user, permission) do
    permission in user.permissions
  end
end
