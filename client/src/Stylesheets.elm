port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)


--

import Style.Main


--


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "index.css", Css.File.compile Style.Main.styles ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure
