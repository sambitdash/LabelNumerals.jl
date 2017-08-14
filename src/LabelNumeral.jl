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

# Standard functions
# Conversion + promotion
Base.convert(::Type{Bool}, num::LabelNumeral) = true
Base.convert(::Type{BigInt}, num::LabelNumeral) = BigInt(Int(num))
Base.convert{T <: Integer}(::Type{T}, num::LabelNumeral) = convert(T, num.val)
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
==(n1::LabelNumeral, n2::LabelNumeral) = Int(n1) == Int(n2)

# Comparisons
isless(n1::LabelNumeral, n2::LabelNumeral) = Int(n1) < Int(n2)
<(n1::LabelNumeral, n2::LabelNumeral) = Int(n1) < Int(n2)
>(n1::LabelNumeral, n2::LabelNumeral) = Int(n1) > Int(n2)
<=(n1::LabelNumeral, n2::LabelNumeral) = Int(n1) <= Int(n2)

## Arithmetic
# Multiple argument operators
for op in [:+, :-,:max, :min]
    @eval ($op){T <: Integer}(n1::LabelNumeral{T}, n2::LabelNumeral{T},
        ns::LabelNumeral{T}...) =
        $(op)(Int(n1), Int(n2), map(Int, ns)...) |> LabelNumeral{T}
end
