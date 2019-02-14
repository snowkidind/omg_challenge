defmodule OmgWeb.TranscribeTest do

  use ExUnit.Case

  test "Responds to expected data set appropriately" do
    assert Transcribe.start(params()) == response()
  end

  def response() do

[
  %{
    children: [
      %{
        children: [
          %{children: [], id: 17, level: 2, parent_id: 12, title: "Blue Window"},
          %{children: [], id: 15, level: 2, parent_id: 12, title: "Red Window"}
        ],
        id: 12,
        level: 1,
        parent_id: 10,
        title: "Red Roof"
      },
      %{children: [], id: 18, level: 1, parent_id: 10, title: "Blue Roof"},
      %{
        children: [
          %{children: [], id: 16, level: 2, parent_id: 13, title: "Door"}
        ],
        id: 13,
        level: 1,
        parent_id: 10,
        title: "Wall"
      }
    ],
    id: 10,
    level: 0,
    parent_id: nil,
    title: "House"
  }
]

  end

  def params() do
  %{
  "0" => [
    %{
      "children" => [],
      "id" => 10,
      "level" => 0,
      "parent_id" => nil,
      "title" => "House"
    }
  ],
  "1" => [
    %{
      "children" => [],
      "id" => 12,
      "level" => 1,
      "parent_id" => 10,
      "title" => "Red Roof"
    },
    %{
      "children" => [],
      "id" => 18,
      "level" => 1,
      "parent_id" => 10,
      "title" => "Blue Roof"
    },
    %{
      "children" => [],
      "id" => 13,
      "level" => 1,
      "parent_id" => 10,
      "title" => "Wall"
    }
  ],
  "2" => [
    %{
      "children" => [],
      "id" => 17,
      "level" => 2,
      "parent_id" => 12,
      "title" => "Blue Window"
    },
    %{
      "children" => [],
      "id" => 16,
      "level" => 2,
      "parent_id" => 13,
      "title" => "Door"
    },
    %{
      "children" => [],
      "id" => 15,
      "level" => 2,
      "parent_id" => 12,
      "title" => "Red Window"
    }
   ]
  }

  end
end
