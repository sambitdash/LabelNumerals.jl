using LabelNumerals
using Base.Test
using RomanNumerals


@testset "RomanNumeral test" begin
    # Constructor tests
    @test LabelNumeral(RomanNumeral, 46) == LabelNumeral(RomanNumeral, "XLVI")
    @test LabelNumeral(RomanNumeral, 1999) == LabelNumeral(RomanNumeral, "MCMXCIX")
    @test LabelNumeral(rn"XXXX") == LabelNumeral(rn"XL")
    @test LabelNumeral(RomanNumeral,1) == LabelNumeral(rn"I")
    @test LabelNumeral(rn"xx") == LabelNumeral(rn"XX")

    @test_throws InvalidRomanError RomanNumeral("nope")
    @test_throws InvalidRomanError RomanNumeral("XLX")

    # arithmetic tests
    @test LabelNumeral(rn"I") + LabelNumeral(rn"IX") == LabelNumeral(rn"X")
    @test LabelNumeral(rn"L") - LabelNumeral(RomanNumeral, 1) == LabelNumeral(rn"XLIX")
    @test LabelNumeral(rn"X") > LabelNumeral(rn"IX")
    @test LabelNumeral(rn"IX") <= LabelNumeral(rn"X")
    @test LabelNumeral(rn"IX") < LabelNumeral(rn"X")
    @test isless(LabelNumeral(rn"IX"), LabelNumeral(rn"X"))
    @test begin
        max(LabelNumeral(rn"C"), LabelNumeral(rn"X"), LabelNumeral(rn"M")) ==
            LabelNumeral(rn"M")
    end
    @test begin
        min(LabelNumeral(rn"M"), LabelNumeral(rn"X"), LabelNumeral(rn"C")) ==
            LabelNumeral(rn"X")
    end
    @test string(LabelNumeral(rn"X"; prefix="A-",caselower=true)) == "A-x"
end


@testset "Integer test" begin
    # Constructor tests
    @test LabelNumeral(Int, 46) == LabelNumeral(Int, "46")
    @test LabelNumeral(Int, 1999) == LabelNumeral(Int, "1999")
    @test LabelNumeral(1000) == LabelNumeral("1000")
    @test LabelNumeral(Int,1) == LabelNumeral("1")

    # arithmetic tests
    @test LabelNumeral(1) + LabelNumeral(9) == LabelNumeral(10)
    @test LabelNumeral(10) - LabelNumeral(1) == LabelNumeral(9)
    @test LabelNumeral(10) > LabelNumeral(9)
    @test LabelNumeral(9) <= LabelNumeral(10)
    @test LabelNumeral(9) < LabelNumeral(10)
    @test isless(LabelNumeral(9), LabelNumeral(10))
    @test begin
        max(LabelNumeral(100), LabelNumeral(10), LabelNumeral(1000)) ==
            LabelNumeral(1000)
    end
    @test begin
        min(LabelNumeral(1000), LabelNumeral(10), LabelNumeral(100)) ==
            LabelNumeral(10)
    end
    @test string(LabelNumeral(10; prefix="A-",caselower=true)) == "A-10"
end

@testset "AlphaNumeral test" begin
    # Constructor tests
    @test LabelNumeral(AlphaNumeral, 46) == LabelNumeral(AlphaNumeral, "TT")
    @test LabelNumeral(AlphaNumeral, 156) == LabelNumeral(AlphaNumeral, "ZZZZZZ")
    @test LabelNumeral(AlphaNumeral, 1) == LabelNumeral(AlphaNumeral, "A")
    @test hash(LabelNumeral(AlphaNumeral, "BBB")) == 0x74df751371ae5632

    println(LabelNumeral(AlphaNumeral, "BBB"))

    @test convert(Bool, LabelNumeral(AlphaNumeral,100)) == true
    @test convert(BigInt, LabelNumeral(AlphaNumeral,100)) == BigInt(100)
    @test convert(Int, LabelNumeral(AlphaNumeral,100)) == 100
    @test convert(LabelNumeral{AlphaNumeral}, 100) == LabelNumeral(AlphaNumeral, 100)
    @test LabelNumeral(AlphaNumeral, 100) + 10 == 110

    @test_throws DomainError LabelNumeral(AlphaNumeral, "ABC")
    @test_throws DomainError LabelNumeral(AlphaNumeral, "157")
    @test_throws DomainError LabelNumeral(AlphaNumeral, "0")
    @test_throws DomainError LabelNumeral(AlphaNumeral, 157)
    @test_throws DomainError LabelNumeral(AlphaNumeral, 0)

    # arithmetic tests
    @test LabelNumeral(an"II") + LabelNumeral(an"A") == LabelNumeral(an"JJ")
    @test LabelNumeral(an"JJ") - LabelNumeral(an"A") == LabelNumeral(an"II")
    @test LabelNumeral(an"JJ") > LabelNumeral(an"II")
    @test LabelNumeral(an"Z") <= LabelNumeral(an"BB")
    @test LabelNumeral(an"Z") < LabelNumeral(an"BB")
    @test isless(LabelNumeral(an"Z"), LabelNumeral(an"BB"))
    @test begin
        max(LabelNumeral(an"I"), LabelNumeral(an"AA"), LabelNumeral(an"A")) ==
            LabelNumeral(an"AA")
    end
    @test begin
        min(LabelNumeral(an"I"), LabelNumeral(an"AA"), LabelNumeral(an"A")) ==
            LabelNumeral(an"A")
    end
    @test string(LabelNumeral(an"J"; prefix="A-",caselower=true)) == "A-j"
end
