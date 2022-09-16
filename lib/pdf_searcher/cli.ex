defmodule PdfSearcher.CLI do
    def run(argv) do
        argv
        |> parse_args
        |> process
    end
end