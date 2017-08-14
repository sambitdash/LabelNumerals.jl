struct AlphaNumeral <: Integer
    val::Int
    str::String
end

AlphaNumeral(str::String) = parse(AlphaNumeral, str)
AlphaNumeral(n::Int) = convert(AlphaNumeral, n)

Base.hash(num::AlphaNumeral) = xor(hash(num.str), hash(num.val))

Base.typemax(::Type{AlphaNumeral}) = 156 # ZZZZZZ
Base.typemin(::Type{AlphaNumeral}) = 1

macro an_str(str)
    AlphaNumeral(str)
end

Base.convert{T <: Integer}(::Type{T}, num::AlphaNumeral) = convert(T, num.val)

function Base.parse(::Type{AlphaNumeral}, str::String)
    s = uppercase(str)
    c = s[1]
    cnt = 0
    for a in s
        if a != c
            throw(DomainError())
        end
        cnt += 1
    end
    val = 26*(cnt-1) + (c - 'A') + 1
    if typemin(AlphaNumeral) <= val <= typemax(AlphaNumeral)
        return AlphaNumeral(val, str)
    else
        throw(DomainError())
    end
end

function Base.convert(::Type{AlphaNumeral}, val::Int)
    if typemin(AlphaNumeral) <= val <= typemax(AlphaNumeral)
        n = div(val, 26)
        r = rem(val, 26)
        if r == 0
            r = 26
            n -= 1
        end
        str = string(fill(Char('A' + r -1),(n+1))...)
        return AlphaNumeral(val, str)
    else
        throw(DomainError())
    end
end
