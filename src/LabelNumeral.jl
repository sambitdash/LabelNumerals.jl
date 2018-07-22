using Compat
# Base 26 number where alphabets are numbers.

"""
```
    LabelNumeral{T<:Integer}
```
Wrapper around an `Integer` type that provides the following caabilities:

1. Prefix - like A-1, A-2 etc...
2. Lower case or upper case conversions
3. show and print options.
4. Mathematical operators like `+, -, <=, ==, >, isless, max and min`

The wrapped `struct` should implement the following methods:
```
1. T(::String)
2. T(::Int)
3. Base.hash(::T)
4. Base.convert{S <: Integer}(::Type{S}, num::T)  <-- to covert to standard numeral types
```
"""
mutable struct LabelNumeral{T<:Integer} <: Integer
    val::T
    prefix::String
    caselower::Bool
end

"""
```
    LabelNumeral{T <: Integer}(::T; prefix="", caselower=false)
    LabelNumeral{T <: Integer}(::Type{T}, i::Integer; prefix="", caselower=false)
    LabelNumeral{T <: Integer}(::Type{T}, s::String; prefix="", caselower=false)
```
Example:
```
julia> using RomanNumerals

julia> a = LabelNumeral(rn"XXIV"; prefix="A-", caselower=true)
A-xxiv

julia> a = LabelNumeral(rn"XXIV"; prefix="A-")
A-XXIV
```
Constructors for LabelNumeral
"""
LabelNumeral{T <: Integer}(t::T; prefix="", caselower=false) =
    LabelNumeral(t, prefix, caselower)
LabelNumeral{T <: Integer}(t::Type{T}, i::Integer; prefix="", caselower=false) =
    LabelNumeral(t(i),prefix, caselower)
LabelNumeral{T <: Integer}(t::Type{T}, str::String; prefix="", caselower=false) =
    LabelNumeral(parse(T, str), prefix, caselower)

"""
```
    LabelNumeral(s::String; prefix="", caselower=false) --> LabelNumeral{Int}
```
Specialized constructor to return a LabelNumeral{Int} type.

Example:
```
julia> a = LabelNumeral("23"; prefix="A-", caselower=true)
A-23
```
The `prefix` does not get affected by the `caselower` parameter.
"""
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
