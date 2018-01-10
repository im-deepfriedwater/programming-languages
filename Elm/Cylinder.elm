module Cylinder exposing (..)

type alias Cylinder =
    { height : Float
    , radius : Float
    }

new : Cylinder
new =
    Cylinder 1 1

volume : Cylinder -> Float
volume {height, radius} =
    pi * radius ^ 2 * height

surfaceArea : Cylinder -> Float
surfaceArea {height, radius} =
    2 * pi * radius * height + 2 * pi * radius ^ 2

widen : Float -> Cylinder -> Cylinder
widen factor {height, radius} =
    Cylinder height (radius * factor)

stretch : Float -> Cylinder -> Cylinder
stretch factor {height, radius}  =
    Cylinder (height * factor) radius
