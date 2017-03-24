module App.Subscription exposing(subscriptions)

import App.Model exposing(Model)

subscriptions: Model -> Sub msg
subscriptions model =
    Sub.none
