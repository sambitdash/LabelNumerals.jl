# Regex to validate a Roman numeral
using RomanNumerals

Base.parse(::Type{RomanNumeral}, str::String) = RomanNumeral(str)

getval(num::RomanNumeral) = num.val

Base.string(num::LabelNumeral{Int}) = begin
    sval = getval(num) |> Base.string
    if num.caselower
        sval = lowercase(sval)
    end
    num.prefix*sval
end

getval(num::Int) = num
