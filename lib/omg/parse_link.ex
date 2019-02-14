defmodule OmgWeb.ParseLink do

@api_url "https://api.github.com/search/repositories"

@doc"""

Parse Link Headers from Github in order to display paginated set of search results.

"""

# pragma mark 'github'

  # Added Link header processing
  def link_headers(original_headers) do

    # Grab the link headers and Regex for pagination
    # Note: contemplated writing this with |> but decided against it
    link_dirty = link(original_headers)
    link_reg = for item <- link_dirty, do: Regex.replace(~r/<|>|\"|\ /, item, "")
    link_maps = for item <- link_reg, do: String.split(item, ";")
    last = get_max_from_link(link_maps) # determine last page for display
    link = list_org(link_maps) # should be sent 4 items
    {last, link}
  end

# pragma mark 'Processing Link Headers'

  # extract link headers
  def link([]), do: "application/json"
  def link([{ "Link", val } | _]) do val |> String.split(",") end
  def link([_ | t]), do: t |> link

  # convert list of lists into maps
  def list_org(list) do
    list
    |> list_of_maps()
    |> sort_maps()
    |> flatten_to_map()
  end

  # the overarching problem here is that the list is not ordered. nor is
  # it pretty to deal with on the .eex file. it also delivers a list of maps, unideal.
  # additional issue is that since it only delivers adjacent direction it makes for errors
  # around the beginning and the end of the display
  defp list_of_maps list do
    for item <- list do
      [url | rel_list] = item
      query_string = remove_url(url)
      [ rel_string | _ ] = rel_list
      case rel_string do
        # if no rel-last, how can we know max pages?
        "rel=first" -> %{first: query_string, sort: 1}
        "rel=last" -> %{last: query_string, sort: 4}
        "rel=prev" -> %{prev: query_string, sort: 2}
        "rel=next" -> %{next: query_string, sort: 3}
      end
    end
  end

  defp sort_maps list_of_maps do
    Enum.sort_by(list_of_maps, fn(map) -> (map.sort) end)
  end

  defp flatten_to_map list_of_maps do
    case length(list_of_maps) do
      4 ->
        [first, prev, next, last | _ ] = list_of_maps
        map = %{first: first.first, previous: prev.prev, next: next.next, last: last.last }
      2 ->
        [a, b | _ ] = list_of_maps
        # if incomplete set decide whether "head" or "tail" of the results
        if Map.has_key?(a, :first) do
            map = %{ first: a.first, previous: b.prev}
          else
            map = %{ next: a.next, last: b.last}
        end
    end
  end

  # would prefer to pull this sort of thing from a config file
  defp remove_url url do
    String.replace(url, @api_url, "")
  end

# pragma mark 'Extract Last Page from Link header'

  def get_max_from_link(list) do
    # dig through link tags and extract kv pairs , namely page
    max = fn list ->
      for item <- list do
        [h | t ] = item
        p = String.split(h, "\&")
        t = for i <- p do String.split(i, "=") end
        v = for item <- t do
          [key | val] = item
          if key == "page" do [val] end
        end
      end
    end

    max.(list)
    |> List.flatten                      # flatten list
    |> Enum.filter(& !is_nil(&1))        # filter nils
    |> Enum.map( &String.to_integer/1)   # convert to ints
    |> maxf()                            # calc max
  end

  # Extract Max Integer Value from a list
  def maxf([head|tail]), do: maxf(head, tail)
  defp maxf(current, []), do: current
  defp maxf(current, [head|tail]) when current < head do
    maxf(head, tail)
  end
  defp maxf(current, [_|tail]), do: maxf(current, tail)

end
