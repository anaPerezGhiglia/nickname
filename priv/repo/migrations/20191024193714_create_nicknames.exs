defmodule Nickname.Repo.Migrations.CreateNicknames do
  use Ecto.Migration

  def change do
    create table(:nicknames) do
      add :nickname, :string
      add :url, :string
      add :times, :integer

      timestamps()
    end

  end
end
