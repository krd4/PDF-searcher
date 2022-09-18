defmodule PdfSearcher.Google do
    @headers [
        {
            "User-Agent",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0) Gecko/20100101 Firefox/104.0"
        },
        {
            "Accept",
            "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8"
        }
    ]

    def get_pages_url(document) do
        document
    end

    def url(kw) do
        "https://www.google.com/search?client=firefox-b-d&q=#{kw}"
        |> String.replace(" ", "+")
    end

    def fetch(kw) do
        url(kw)
        |> HTTPoison.get(
            @headers
        )
    end

    def handle_response({:ok, %{status_code: status_code, body: body}}) do
        {
            status_code |> check_for_error(),
            body |> process_body()
        }
    end

    def check_for_error(200), do: :ok
    def check_for_error(_), do: :error

    def process_body(body) do
        body
        |> Floki.parse_document()
        |> get_pages_url()
    end
end