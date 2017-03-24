module Main exposing (main)

import App.Model exposing(Model)
import App.Init exposing(init)
import App.View exposing(view)
import App.Update exposing(update)
import App.Subscription exposing(subscriptions)
import App.Msg   exposing(Msg)

import Html exposing(program)


-- Headless
---http://package.elm-lang.org/packages/elm-lang/core/5.1.1/Platform#program
--
-- Html based 
-- http://package.elm-lang.org/packages/elm-lang/html/2.0.0/Html#program
main : Program Never Model Msg
main =
    program
        { init = init      -- initialize the model
        , view = view      -- display the model
        , update = update  -- update the model
        , subscriptions = subscriptions -- external input (sockets, keyboard, side-effects)
        }

