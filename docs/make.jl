push!(LOAD_PATH,"../src/")

using Documenter, LabelNumerals

makedocs(
    format = Documenter.HTML(),
    modules = [LabelNumerals],
    sitename = "LabelNumerals",
    pages = [
        "index.md"
    ]
)
