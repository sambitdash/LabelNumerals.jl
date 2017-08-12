module LabelNumerals

import Base: ==, isless, <, >, <=, +, -, max, min,
             convert, promote_rule, print, show, string, hash, parse

include("LabelNumeral.jl")
include("AlphaNumeral.jl")
include("ExtNumerals.jl")
include("LookupNumeral.jl")
include("AlphaNumNumeral.jl")


export LabelNumeral,
       @an_str, AlphaNumeral,
       @ln_str, LookupNumeral, registerLookupNumerals,
       @ann_str, AlphaNumNumeral
end # module
