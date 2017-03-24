module App.Init exposing (init)

import App.Model exposing(Model,Inventory,Dress,Variant)

import App.Msg   exposing(..)

init: ( Model, Cmd Msg)
init =
    (initial_state, Cmd.none)


initial_state : Model
initial_state  =
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
