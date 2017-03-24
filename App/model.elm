module App.Model exposing(Model,Inventory,Dress,Variant)

type alias Model = Inventory

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
