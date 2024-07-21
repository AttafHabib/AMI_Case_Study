defmodule ExAssignment.Repo.Migrations.AlterTableTodoAddIsNext do
  use Ecto.Migration

  def change do
    alter table(:todos) do
      add(:is_next, :boolean, default: false, null: false)
    end
  end
end
