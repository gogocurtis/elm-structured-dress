module App.View exposing(view)

import App.Model exposing(Model,Dress,Variant)

import App.Msg   exposing(..)

import Html exposing (Html, ul, li, div, dd, dt, dl, text, h3, button, img, span)

import Html.Attributes exposing (class)

import Html.Events exposing (onClick)


view: Model -> (Html Msg)
view inventory =
    div []
        [ h3 [ class "inventory" ] [ text
                                         ("Inventory  (Version"
                                              ++
                                              String.fromInt inventory.version
                                              ++
                                              ")")
                                   ]
        , ul [ class "dresses" ] (dresses inventory.dresses)
        ]


dresses : List Dress -> List (Html Msg)
dresses list =
    List.map (\d -> dress d ) list


dress : Dress -> Html Msg
dress model =
    if model.visible then
      li [ class "dress" ]
          [
            dress_action model
          , name model.name
          , variants model.variants
          ]
    else
      li [ class "dress hidden"] [ dress_action model]

dress_action: Dress -> Html Msg
dress_action model =
    if model.visible == True then
        button [onClick (Collapse model)] [text ("Hide" ++ String.fromInt model.id)]
    else
        button [onClick (Expand model)] [text ("Show" ++ String.fromInt model.id)]


variants : List Variant -> Html msg
variants list =
    ul [ class "variants" ]
        (List.map (\v -> variant v) list)


variant : Variant -> Html msg
variant model =
    li [ class "variant" ]
        [ color model.color
        , price model.price
        , size  model.size
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
