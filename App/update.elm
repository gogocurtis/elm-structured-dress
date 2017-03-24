module App.Update exposing(update)

import App.Model exposing(Model,Dress,Inventory)

import App.Msg   exposing(..)

import List exposing(head)


update: Msg -> Model -> (Model, Cmd Msg)
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
