module App.Msg exposing(..)

import App.Model exposing(Dress)


type Msg
    =  Expand Dress | Collapse Dress
