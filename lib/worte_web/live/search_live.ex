defmodule WorteWeb.SearchLive do
  use Phoenix.LiveView


  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: nil, result: nil, loading: false, matches: [])}
  end

  def handle_event("suggest", %{"q" => query}, socket) when byte_size(query) <= 100 do
    words = Worte.Worterbuch.find_defined_words(query)
    IO.inspect(words)
    {:noreply, assign(socket, matches: words)}
  end

  def handle_event("search", %{"q" => query}, socket) when byte_size(query) <= 100 do
    send(self(), {:search, query})
    {:noreply, assign(socket, query: query, result: nil, loading: true, matches: [])}
  end

  def handle_info({:search, query}, socket) do
    IO.puts("handle_info")
    result = Worte.Worterbuch.find_definition(query)
    # IO.inspect(words)
    # result = Enum.map(words, &List.first/1)
    IO.inspect(result)
    {:noreply, assign(socket, loading: false, result: result, matches: [])}
  end

  def render(assigns) do
    ~L"""
    <div>
    <form phx-change="suggest" phx-submit="search">
      <input type="text" name="q" value="<%= @query %>" list="matches" placeholder="Search..."
             <%= if @loading, do: "readonly" %>/>
      <datalist id="matches">
        <%= for match <- @matches do %>
          <option value="<%= match %>"><%= match %></option>
        <% end %>
      </datalist>
    </form>
      <%= if @result do %>
        <%= for [definition | rest] <- @result  do %>
          <div class="definition">
            <span><%= elem(definition,0) %></span>
            <span><%= elem(definition,1) %></span>
          </div>
          <%= for word <- rest  do %>
            <div class="example">
              <span><%= elem(word,0) %></span>
              <span><%= elem(word,1) %></span>
            </div>
          <% end %>
        <% end %>
      <% end %>
    </div>
    """
  end
end
