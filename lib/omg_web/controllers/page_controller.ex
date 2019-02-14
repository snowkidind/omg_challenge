defmodule OmgWeb.PageController do

  use OmgWeb, :controller

  def index(conn, params) do

    IO.inspect params

    # 1. Compose Api request string
    # template: url = "https://api.github.com/search/repositories?q=elixir&per_page=10&page=1"
    api_url = "https://api.github.com/search/repositories?"
    {github_params, page, query} = set_params(params)
    url =  "#{api_url}#{github_params}"
    headers = ["User-Agent": "OmiseGo"]

    # 2. execute and parse
    {status, body, original_headers} = OmgWeb.Myclient.Api.get(url, headers)

    # 3. if search results were found... parse results
    if body.total_count > 0 do

      # crunch the link headers to determine navigation
      {last, link} = OmgWeb.Myclient.Api.link_headers(original_headers)

      # select appropriate data from github response to carry forth
      data = for item <- body.items, do: %{
        name: item.name,
        description: item.description,
        homepage: item.html_url,
        language: item.language
      }

      # last page bug
      page_int = String.to_integer(page)
      last_page = if page_int > last do page else last end

      # 4. print to screen
      render(conn, "index.html", link: link, data: data, page: page, last: last_page, query: query)

    else
      # display no results? no, requery with default search
      # ideally, it would just display empty results and protect bad search.
      conn
      |> put_flash(:error, "No results found. Displaying default search.")
      |> redirect(to: Routes.page_path(conn, :index))

    end
  end

  defp set_params(params) do
    q = fn -> if Map.has_key?(params, "q") do params["q"] else "Elixir" end end
    page = fn -> if Map.has_key?(params, "page") do params["page"] else "1" end end
    per_page = fn -> if Map.has_key?(params, "per_page") do params["per_page"] else 10 end end
    query = String.replace(q.(), " ", "+")
    {"&q=#{query}&page=#{page.()}&per_page=#{per_page.()}&User-Agent=OmiseGo", page.(), query}
  end

end
