mutable struct LabelNumeral{T<:Integer} <: Integer
    val::T
    prefix::String
    caselower::Bool
end

LabelNumeral{T <: Integer}(t::T; prefix="", caselower=false) =
    LabelNumeral(t, prefix, caselower)

LabelNumeral{T <: Integer}(t::Type{T}, i::Integer; prefix="", caselower=false) =
    LabelNumeral(t(i),prefix, caselower)

LabelNumeral{T <: Integer}(t::Type{T}, str::String; prefix="", caselower=false) =
    LabelNumeral(parse(T, str), prefix, caselower)

LabelNumeral(str::String; prefix="", caselower=false) =
    LabelNumeral(parse(Int, str), prefix, caselower)

getval(num::LabelNumeral)=getval(num.val)

# Standard functions
# Conversion + promotion
Base.convert(::Type{Bool}, num::LabelNumeral) = true
Base.convert(::Type{BigInt}, num::LabelNumeral) = BigInt(getval(num))
Base.convert{T <: Integer}(::Type{T}, num::LabelNumeral) = convert(T, getval(num))
Base.convert{T <: Integer}(::Type{LabelNumeral{T}}, num::Int) = LabelNumeral(T, num)
Base.promote_rule{T <: Integer, S <: Integer}(::Type{LabelNumeral{S}}, ::Type{T}) = T

Base.string(num::LabelNumeral) = begin
    sval = num.val.str
    if num.caselower
        sval = lowercase(sval)
    end
    num.prefix*sval
end

# IO
Base.print(io::IO, num::LabelNumeral) = print(io, Base.string(num))
Base.show(io::IO, num::LabelNumeral) = write(io, Base.string(num))

Base.hash(num::LabelNumeral) = xor(hash(num.prefix), hash(num.val))

import Base: ==, isless, <=, <, >,
    +, -, max, min

# Equality operators
==(n1::LabelNumeral, n2::LabelNumeral) = getval(n1) == getval(n2)

# Comparisons
isless(n1::LabelNumeral, n2::LabelNumeral) = getval(n1) < getval(n2)
<(n1::LabelNumeral, n2::LabelNumeral) = getval(n1) < getval(n2)
>(n1::LabelNumeral, n2::LabelNumeral) = getval(n1) > getval(n2)
<=(n1::LabelNumeral, n2::LabelNumeral) = getval(n1) <= getval(n2)

## Arithmetic
# Multiple argument operators
for op in [:+, :-,:max, :min]
    @eval ($op){T <: Integer}(ns::LabelNumeral{T}...) =
        $(op)(map(n -> getval(n), ns)...) |> LabelNumeral{T}
end
