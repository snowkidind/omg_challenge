defmodule Transcribe do

  def start(map) do

    p = map["0"]
    c = map["1"]
    n = map["2"]

    # 1. make map useable
    parent = list_to_atom(p)
    children = list_to_atom(c)
    nephews = list_to_atom(n)

    nephews
    # 2. attach nephews to children
    |> build_descendants(children)

    # 3. add child array to parent
    |> build_descendants(parent)

  end

  # Attach nephews to children list
  defp build_descendants(nephews, children) do

    # dig through the children list
    Enum.map children, fn child ->

      # match the nephews to this child
      nephews
      |> pick_parent_id(child.id)
      |> add_child(child)
    end
  end

  defp pick_parent_id(maps, pid) do
    for var = %{parent_id: parent_id} <- maps, parent_id == pid, do: var
  end

  defp add_child(result, child) do
    %{ child | children: result}
  end

  # convert collection to atoms
  def list_to_atom(map) do
    # convert a list of "" 'ed maps into an atom useable list of maps
    for n <- map, do: to_atom(n)
  end

  def to_atom(map) do
    for {key, val} <- map, into: %{}, do: {String.to_atom(key), val}
  end
end