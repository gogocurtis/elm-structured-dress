-- TODO: break module into directory structure (dress/types, dress/data, dress/messages, dress/main dress/update dress/view)
--













module Dress exposing (main, initial_inventory, Dress, Variant, Inventory)

import List exposing(head)


import Html exposing (Html, program, ul, li, div, dd, dt, dl, text, h3, button, img, span)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Maybe exposing(..)


-- types
--         Model
type alias Inventory =
    {
      version        : Int
    , dresses        : List Dress
    -- Talking point: adding a field that isn't used that isn't optional
    }


type alias Dress =
    { id          : Int
    , name        : String
    , description : Maybe String -- Talking Point : optional value, not optional position
    , images      : Maybe (List String)
    , variants    : List Variant
    , visible     : Bool
    }


type alias Variant =
    { color : String
    , price : String
    , size  : String
    }


-- data
-- Talking point: Explicit vs Implicit type spec
initial_inventory : Inventory
initial_inventory  =
    Inventory 1
        [ Dress 1        -- ID
            "Lauren"     -- name
            Nothing      -- description
            Nothing      -- images 
            [ Variant "royal blue" "$750" "6"
            , Variant "royal blue" "$750" "10"
            , Variant "royal blue" "$750" "11"
            , Variant "cinnamon red" "$750" "10"
            , Variant "race yellow" "$750" "14"
            , Variant "Race yellow & black limited edition" "$1250" "19"
            ] False --visible
        , Dress 2        -- id
            "A Vengance" -- name
            (Just "")    -- desc
            (Just [      -- images
                  "http://karleeneberle.com/images/portfolio/portfolio_gallery_1_2.jpg"
                 , "http://karleeneberle.com/images/portfolio/portfolio_gallery_1_2.jpg"
                 ]
            )
            [ Variant "french blue" "$750" "6" -- variants
            , Variant "french blue" "$750" "10"
            , Variant "french blue" "$750" "11"
            , Variant "bull red" "$750" "10"
            , Variant "canary yellow" "$750" "14"
            ] False -- visible
        ] 



--- render main

-- Talking Point : defining main
-- Headless
---http://package.elm-lang.org/packages/elm-lang/core/5.1.1/Platform#program
--
-- Html based 
-- http://package.elm-lang.org/packages/elm-lang/html/2.0.0/Html#program
main : Program Never Inventory Msg
main =
    program
        { init = init      -- initialize the model
        , view = view      -- display the model
        , update = update  -- update the model
        , subscriptions = subscriptions -- external input (sockets, keyboard, side-effects)
        }

--- Html.program

init: ( Inventory, Cmd Msg)
init =
    (initial_inventory, Cmd.none)

-- Talking point:  Defining Msg
-- messages
type Msg
    =  Expand Dress | Collapse Dress 

update: Msg -> Inventory -> (Inventory, Cmd Msg)
update message inventory =
    case message of
        (Expand dress) ->
            (
             (updateDressInventory (setVisibility dress True) inventory)
            , Cmd.none
            )

        (Collapse dress) ->
            (
             (updateDressInventory (setVisibility dress False) inventory)
            , Cmd.none
            )

subscriptions: Inventory -> Sub msg
subscriptions inventory =
    Sub.none

view: Inventory -> (Html Msg)
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

--- update

setVisibility: Dress -> Bool -> Dress
setVisibility dress bool =
    -- OMHG this is exciting - the { object | field = NewValue} operator allows
    -- us to create a new dress representation with an updated visibility
    -- field
    {dress | visible = bool}

-- this basically allows us to swap a dress in place
-- in the inventory for a different one.
updateDressInventory: Dress -> Inventory -> Inventory
updateDressInventory updatedDress inventory =
  let
    select existingDress =
      if existingDress.id == updatedDress.id then
          updatedDress
      else
          existingDress
  in
  -- replace the dresses field in inventory with the updated inventory
  { inventory |
        dresses =  List.map select inventory.dresses ,
        version =  inventory.version + 1
  }

--- view helpers


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
