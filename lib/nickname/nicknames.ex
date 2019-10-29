defmodule Nickname.Nicknames do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nicknames" do
    field :nickname, :string
    field :times, :integer
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(nicknames, attrs) do
    nicknames
    |> cast(attrs, [:nickname, :url, :times])
    |> validate_required([:nickname, :url, :times])
  end
end
