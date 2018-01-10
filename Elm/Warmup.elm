module Warmup exposing (change, stripQuotes, powers, sumOfCubesOfOdds, daysBetween)

import List exposing (map, filter, foldr)
import Regex exposing (replace, regex)
import String exposing (slice, toInt)

-- A function that accepts a number of U.S. cents and returns a tuple containing, respectively,
-- the smallest number of U.S. quarters, dimes, nickels, and pennies that equal the given amount.
change : Int -> Result String ( Int, Int, Int, Int )
change amount =
    if amount < 0 then Err "amount cannot be negative"
    else
        let
            (numQuarters, leftOverQuarters) = divmod amount 25
            (numDimes, leftOverDimes) = divmod leftOverQuarters 10
            (numNickels, numPennies) = divmod leftOverDimes 5
        in
            Ok (numQuarters, numDimes, numNickels, numPennies)

divmod : Int -> Int -> (Int, Int)
divmod amount divisor =
    (amount // divisor, amount % divisor)

-- A function that accepts a string and returns a new string equivalent to the argument but with
-- all apostrophes and double quotes removed.
stripQuotes : String -> String
stripQuotes string =
    replace Regex.All (regex "[\"\']") (\_ -> "") string

-- A function that returns a list of successive powers of a base starting at 1 and going up to some limit.
powers : Int -> Int -> Result String (List Int)
powers base limit =
    if base < 0 then Err "negative base"
    else let recursePower base limit exp =
        if base^exp > limit then []
            else base^exp::(recursePower base limit (exp + 1))
        in
            Ok <| recursePower base limit 0

-- A function that returns the sum of the cubes of all of the odd integers in a list. Use map, filter, and foldr.
sumOfCubesOfOdds : List Int -> Int
sumOfCubesOfOdds list =
    foldr (+) 0 (map cube (filter isOdd list))

cube : Int -> Int
cube num =
    num ^ 3

isOdd : Int -> Bool
isOdd num =
    num % 2 /= 0

-- A function that returns the number of days between two dates, where the dates are given as strings in the format "YYYY-MM-DD".
convertToDays : ( Int, Int, Int ) -> Int
convertToDays parsedDates =
    let
        (months, years, days) = parsedDates
        m = (9 + months) % 12
        y = (years) - m // 10
        d = days
    in
        365 * y + y // 4 - y // 100 + y // 400 + (m * 306 + 5) // 10 + (d - 1)

daysBetween : String -> String -> Result String Int
daysBetween from to =
    case parseMYD from of
        Err msg -> Err msg
        Ok fromMYD ->
            case parseMYD to of
                Err msg -> Err msg
                Ok toMYD -> Ok <| (convertToDays toMYD) - (convertToDays fromMYD)

parseMYD : String -> Result String ( Int, Int, Int )
parseMYD string =
    case toInt (slice 5 7 string) of
        Err msg -> Err msg
        Ok month ->
            case toInt (slice 0 4 string) of
                Err msg -> Err msg
                Ok year ->
                    case toInt (slice 8 10 string) of
                        Err msg -> Err msg
                        Ok day -> Ok (month, year, day)
