struct LookupNumeral <: Integer
    val::Int
    str::String
end

LookupNumeral(str::String) = parse(LookupNumeral, str)
LookupNumeral(n::Int) = fromInt(LookupNumeral, n)

Base.hash(num::LookupNumeral) = xor(hash(num.str), hash(num.val))

LOOKUP_A2N = Dict(
    "One" => 1,
    "Two" => 2,
    "Three" => 3,
    "Four" => 4,
    "Five" => 5,
    "Six" => 6,
    "Seven" => 7,
    "Eight" => 8,
    "Nine" => 9,
    "Ten" => 10,
    "Eleven"=> 11,
    "Twelve" => 12,
    "Thirteen" => 13,
    "Fourteen" => 14,
    "Fifteen" => 15,
    "Sixteen" => 16,
    "Seventeen" => 17,
    "Eighteen" => 18,
    "Nineteen" => 19,
    "Twenty" => 20
)

function reverse_lookup(din::Dict{String,Int})
    dout = Dict{Int, String}()
    for (key, value) in din
        dout[value] = key
    end
    return dout
end


LOOKUP_N2A = reverse_lookup(LOOKUP_A2N)


function registerLookupNumerals(d::Dict{String,Int})
    global LOOKUP_A2N, LOOKUP_N2A
    LOOKUP_A2N = d
    LOOKUP_N2A = reverse_lookup(LOOKUP_A2N)
end

Base.typemax(::Type{LookupNumeral}) = 20
Base.typemin(::Type{LookupNumeral}) = 1

macro ln_str(str)
    LookupNumeral(str)
end

getval(num::LookupNumeral) = num.val

function Base.parse(::Type{LookupNumeral}, str::String)
    if !haskey(LOOKUP_A2N, str)
        throw(DomainError())
    else
        return LookupNumeral(LOOKUP_A2N[str], str)
    end
end

function fromInt(::Type{LookupNumeral}, val::Int)
    if !haskey(LOOKUP_N2A, val)
        throw(DomainError())
    else
        return LookupNumeral(val, LOOKUP_N2A[val])
    end
end
