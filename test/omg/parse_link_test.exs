defmodule OmgWeb.ParseLinkTest do

  use ExUnit.Case

  test "Able to determine the max integer value in a list" do
    assert OmgWeb.ParseLink.maxf([1, 5, 7, 10, 5]) == 10
  end

  test "Able to extract pagination from link headers" do
    assert OmgWeb.ParseLink.link_headers(ok_link_headers()) == {100, ok_link_pagination()}
  end

  def ok_link_pagination do
    %{
      first: "?q=Elixir&page=1&per_page=10&User-Agent=OmiseGo",
      last: "?q=Elixir&page=100&per_page=10&User-Agent=OmiseGo",
      next: "?q=Elixir&page=3&per_page=10&User-Agent=OmiseGo",
      previous: "?q=Elixir&page=1&per_page=10&User-Agent=OmiseGo"
    }
  end

  def ok_link_headers do
    [
      {"Server", "GitHub.com"},
      {"Date", "Thu, 14 Feb 2019 08:14:40 GMT"},
      {"Content-Type", "application/json; charset=utf-8"},
      {"Content-Length", "50586"},
      {"Status", "200 OK"},
      {"X-RateLimit-Limit", "10"},
      {"X-RateLimit-Remaining", "9"},
      {"X-RateLimit-Reset", "1550132140"},
      {"Cache-Control", "no-cache"},
      {"X-GitHub-Media-Type", "github.v3; format=json"},
      {"Link", "<https://api.github.com/search/repositories?q=Elixir&page=1&per_page=10&User-Agent=OmiseGo>; rel=\"prev\", <https://api.github.com/search/repositories?q=Elixir&page=3&per_page=10&User-Agent=OmiseGo>; rel=\"next\", <https://api.github.com/search/repositories?q=Elixir&page=100&per_page=10&User-Agent=OmiseGo>; rel=\"last\", <https://api.github.com/search/repositories?q=Elixir&page=1&per_page=10&User-Agent=OmiseGo>; rel=\"first\""},
      {"Access-Control-Expose-Headers", "ETag, Link, Location, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval, X-GitHub-Media-Type"},
      {"Access-Control-Allow-Origin", "*"},
      {"Strict-Transport-Security", "max-age=31536000; includeSubdomains; preload"},
      {"X-Frame-Options", "deny"},
      {"X-Content-Type-Options", "nosniff"},
      {"X-XSS-Protection", "1; mode=block"},
      {"Referrer-Policy", "origin-when-cross-origin, strict-origin-when-cross-origin"},
      {"Content-Security-Policy", "default-src 'none'"},
      {"X-GitHub-Request-Id", "0918:02EB:AD72FD:15B8837:5C65236F"}
    ]
  end
end