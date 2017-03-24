module App.View exposing(view)

import App.Model exposing(Model,Dress,Variant)

import App.Msg   exposing(..)

import Html exposing (Html, program, ul, li, div, dd, dt, dl, text, h3, button, img, span)

import Html.Attributes exposing (class)

import Html.Events exposing (onClick)


view: Model -> (Html Msg)
view inventory =
    div []
        [ h3 [ class "inventory" ] [ text
                                         ("Inventory  (Version"
                                              ++
                                              toString inventory.version
                                              ++
                                              ")")
                                   ]
        , ul [ class "dresses" ] (dresses inventory.dresses)
        ]


dresses : List Dress -> List (Html Msg)
dresses dresses =
    List.map (\d -> dress d ) dresses


dress : Dress -> Html Msg
dress dress =
    if dress.visible then
      li [ class "dress" ]
          [
            dress_action dress
          , name dress.name
          , variants dress.variants
          ]
    else
      li [ class "dress hidden"] [ dress_action dress]

dress_action: Dress -> Html Msg
dress_action dress =
    if dress.visible == True then
        button [onClick (Collapse dress)] [text ("Hide" ++ toString dress.id)]
    else
        button [onClick (Expand dress)] [text ("Show" ++ toString dress.id)]


variants : List Variant -> Html msg
variants variants =
    ul [ class "variants" ]
        (List.map (\v -> variant v) variants)


variant : Variant -> Html msg
variant variant =
    li [ class "variant" ]
        [ color variant.color
        , price variant.price
        , size variant.size
        ]


name : String -> Html msg
name value =
    (h3) [ class "name" ] [ text value ]


-- without the gnarly "point free style"
color : String -> Html msg
color input  =
    (label_value "color" "Color" input)


-- with the gnarly "point free style"
size : String -> Html msg
size  =
    (label_value "size" "Size") 


price : String -> Html msg
price =
    (label_value "price" "Price")


label_value : String -> String -> String -> Html msg
label_value kind label value =
    dl [ class kind ]
        [ dt [ class "label" ] [ text label ]
        , dd [ class "value" ] [ text value ]
        ]
