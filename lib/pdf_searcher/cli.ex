defmodule PdfSearcher.CLI do
    def run(argv) do
        argv
        |> parse_args
        |> process
    end

    def parse_args(argv) do
        parse = OptionParser.parse(argv, switches: [ help: :boolean], aliases: [h: :help])

        case parse do
            { [ help: true ] } -> :help
            _ -> :help
        end
    end

    def process(:help) do
        IO.puts("""
        usage: pdf_search <keyword>
        """)
    end
end