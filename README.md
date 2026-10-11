# ez_consumables

Food, drink, medicine, drugs and packs, all kept in the database and edited in game with **/manageconsumables**.
Nothing in a config file needs touching to add or change a consumable.

Needs `vorp_core`, `vorp_inventory` and `oxmysql`. Logs admin changes through `ez_logs` when it is running.

## First start

1. Start the resource. Its two tables are created on their own: `ez_consumables_items` and `ez_consumables_effects`.
2. Run **`ez_consumables_migrate`** once in the server console. It reads the old config (`_legacy/shared/config.lua`)
   and imports every consumable, every pack (`Config.ItemToSplit`) and the two old effects (High, Vintage Eye).
   It refuses to run twice; `ez_consumables_migrate reset` wipes both tables and imports again. The old file is never changed.
3. The console lists any item names that aren't in the `items` table. Those still import; fix or delete them in /manageconsumables.
4. Run **`ez_consumables_migrate tobacco`** to bring in ez_tobacco's cigars, cigarettes, pipes and chewing tobacco
   (from a copy in `_legacy/tobacco/config.lua`). Items that are already consumables are skipped, so it is safe to run
   again. Then **remove ez_tobacco**, or its items are registered twice. (Its pocket watches, fans and hair pomade
   moved to bfrp_smallresources.)
5. Once you're happy, `_legacy/` can be deleted. Nothing loads from it after the migration.

Admin changes go to a Discord webhook if you set one (server.cfg / webhooks.cfg):

```
set ez_consumables_webhook "https://discord.com/api/webhooks/..."
```

## /manageconsumables

Groups in `Config.AdminGroups` can open it. Two tabs:

- **Consumables**: search, filter by type. The editor has the item (picker with images), type, hunger / thirst / stress /
  metabolism / alcohol, health and stamina cores and gold, the animation and its
  prop (model, bone, offset, rotation; empty fields use the animation's own), an effect and how long it lasts, cures
  (ends any effect, sobers up), a cooldown, and items it gives back (an empty bottle, or a pack's contents).
  **Preview** plays the animation with the prop on you, then the effect. **Duplicate** copies it for another item.
  Numbers with known limits are sliders that grow from 0: right fills up (gold), left drains (red), and the box beside
  each takes an exact value. The limits live in `Limits` in `shared/functions.lua`; the server holds saves to the same ones.
- **Effects**: screen effects that play the whole time, one-shot screen effects at the start and end, a colour filter,
  wobble, camera shake (fading out over some seconds, or the whole time) and motion blur. **Preview** plays it on you.

While previewing the panel hides and a bar shows what is playing; **Backspace** stops it and brings the panel back.
Previews never use items or change stats.

Every change saves to the database straight away, takes effect for the next use, and shows in other admins' open panels.
New consumables are usable at once, no restart. If the item isn't marked usable in the `items` table the editor says so.

## Smoking and chewing

Pick the Cigar, Cigarette, Pipe or Chew animation and the consumable is held and used a puff at a time:
the player gets **Puff**, **Put away** and **Change stance** prompts (`Config.SmokeKeys`) and a "puffs left" counter.
The editor then shows **Puffs** and **Time per puff**.

- Status, health, stamina and alcohol come with **every puff**.
- Gold, the effect and cures come **once every puff is taken**. Putting it away early keeps what the puffs gave, not the reward.
- **Needs** (any consumable): items the player must have that aren't used up, like a pipe for pipe tobacco.
- Cigars and pipes block fighting while smoked (`blockWeapons` on the animation).

## Using a consumable

The server checks the player isn't already using something, the cooldown, and that they can carry what it gives back,
then takes the exact item stack they used and gives the items. The client plays the animation, then applies the stats,
alcohol, cures and effect. Cooldowns are kept per character on the server.

## Config

`shared/config.lua`: admin command and groups, consumable types and the message each one shows, the animations
(add your own: an anim dict, a game item interaction, or nothing), the suggestion lists in the panel, the drunk levels,
and `Config.ApplyStatus` (swap it out for another metabolism script). `shared/lang.lua` has every string.

Client exports: `GetAlcohol()`, `AddAlcohol(n)`, `SetAlcohol(n)`, `StopEffect()`.
`/consumablelevel alcohol | stamina | health` prints the current levels (for testing).

Drunk system based on https://github.com/RP-Redm/rsg-drinker
