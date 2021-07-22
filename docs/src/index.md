# Numbers as Labels

[![GitHub Action](https://github.com/sambitdash/LabelNumerals.jl/actions/workflows/Build.yml/badge.svg)](https://github.com/sambitdash/LabelNumerals.jl/actions/workflows/Build.yml)
[![Coverage Status](https://coveralls.io/repos/sambitdash/LabelNumerals.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/sambitdash/LabelNumerals.jl?branch=master)
[![codecov.io](http://codecov.io/github/sambitdash/LabelNumerals.jl/coverage.svg?branch=master)](http://codecov.io/github/sambitdash/LabelNumerals.jl?branch=master)

[Dev Documentation](https://sambitdash.github.io/LabelNumerals.jl/docs/build/)


Sometimes, we use numeric quantities for pure representational purposes without any 
true numeric significance. For example, the page numbering is carried out using 
simple Arabic numerals, roman numerals, alphabets. These numbers have additive 
properties but may not have any multiplicative significance. Such numbers can have 
prefix notations as well. In some cases, the representation can be in upper case 
or lower case as well. This package implements such numerals. The interface has a 
similar interface as the RomanNumerals package.

 ## Usage
 LabelNumerals introduces the following new types:

  1. LetterNumeral - `LabelNumeral{AlphaNumeral}` - A, B, ..., Z, AA, BB, ..., ZZ, AAA... (group of 26 characters each)
  2. ArabicNumeral - `LabelNumeral{Int}` - 1, 2, 3, ...
  3. LookupNumeral - `LabelNumeral{LookupNumeral}` - mapped strings to integers like English words "One", "Two" etc.
  4. AlphaNumNumeral - `LabelNumeral{AlphaNumNumeral}` - alphabets representing numbers like BA, BB, BC etc.

 It also supports `RomanNumeral` from
 [`RomanNumerals`](https://github.com/anthonyclays/RomanNumerals.jl) package.

They support ability to provide a string prefix. The prefix does not get incremented as
numbers are incremented.

!!Note: Letter, arabic and roman numerals are used in the PDF file pages as page number
labels.

## LabelNumeral
```@docs
LabelNumeral{T <: Integer}
LabelNumeral{T <: Integer}(t::T; prefix="", caselower=false)
findLabels
```

## AlphaNumeral
```@docs
AlphaNumeral
AlphaNumeral(::String)
@an_str
```

## AlphaNumNumeral
```@docs
AlphaNumNumeral
AlphaNumNumeral(::String)
@ann_str
```
## LookupNumeral
```@docs
LookupNumeral
LookupNumeral(::String)
@ln_str
```

## External Numeral Types

### ArabicNumeral
Represented as `Int` types.

### RomanNumeral
Represented as `RomanNumeral` from the [`RomanNumerals`](https://github.com/anthonyclays/RomanNumerals.jl) package.
