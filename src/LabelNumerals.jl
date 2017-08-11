module LabelNumerals

import Base: ==, isless, <, >, <=, +, -, max, min,
             convert, promote_rule, print, show, string, hash, parse

include("LabelNumeral.jl")
include("AlphaNumeral.jl")
include("ExtNumerals.jl")


export LabelNumeral,
       @an_str, AlphaNumeral

end # module
