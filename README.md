# EZ Consumables

## Description
A simple consumables system for RedM servers. Complete open source and easy to use only via config. Allows you to easily update it to your HUD/ Metabolism system in your server.

## Features
- Consumables system
- Configurable
- Easy to use
- Open source

## Installation
1. Download the resource
2. Extract the resource
3. Place the resource in your resources folder
4. Add `ensure ez_consumables` to your server.cfg
5. Configure the config to your liking

## Requirements
- VORP Core
- VORP Animations (Optional - For eating/ drinking animations)
```lua
["beer"] = {
    Hunger = 0,
    Thirst = 20,
    Stress = 6,
    Stamina = 3,
    InnerStaminaGold = 0,
    OuterStaminaGold = 0,
    InnerHealth = 0,
    OuterHealth = 0,
    InnerHealthGold = 0,
    OuterHealthGold = 0,
    Animation = "drink_beer_bottle" -- Requires VORP Animations to use named animations. Make sure the animation exists in the VORP Animations config.
}
```
... you can simularly use item interactions instead
```lua
["consumable_kidneybeans_can"] = {
    Hunger = 20,
    Thirst = 0,
    Stress = 5,
    Stamina = 2,
    InnerStaminaGold = 0,
    OuterStaminaGold = 0,
    InnerHealth = 0,
    OuterHealth = 7,
    InnerHealthGold = 0,
    OuterHealthGold = 0,
    ItemInteraction = "EAT_CANNED_FOOD_CYLINDER@D8-2_H10-5_QUICK_LEFT"
}
```

