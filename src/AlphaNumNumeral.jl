#Base 26 number where alphabets are numbers.

struct AlphaNumNumeral <: Integer
    val::Int
    str::String
end

AlphaNumNumeral(str::String) = parse(AlphaNumNumeral, str)
AlphaNumNumeral(n::Int) = convert(AlphaNumNumeral, n)

Base.hash(num::AlphaNumNumeral) = xor(hash(num.str), hash(num.val))

macro ann_str(str)
    AlphaNumNumeral(str)
end

Base.convert{T <: Integer}(::Type{T}, num::AlphaNumNumeral) = convert(T, num.val)

function Base.parse(::Type{AlphaNumNumeral}, str::String)
    s = uppercase(str)
    val = 0
    for a in s
        val *= 26
        if 'A' <= a <= 'Z'
            val += (a - 'A')
        else
            throw(DomainError())
        end
    end
    return AlphaNumNumeral(val, str)
end

function Base.convert(::Type{AlphaNumNumeral}, val::Int)
    carr = Vector{Char}()
    tval = val
    while (tval > 0)
        r = rem(tval, 26)
        c = Char('A' + r)
        unshift!(carr, c)
        tval = div(tval, 26)
    end
    str = String(carr)
    return AlphaNumNumeral(val, str)
end
