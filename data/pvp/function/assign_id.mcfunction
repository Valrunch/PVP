scoreboard players add #next_id pvp.nextid 1
scoreboard players operation @s pvp.id = #next_id pvp.nextid
scoreboard players set @s pvp.pending_from 0
scoreboard players set @s pvp.pendingticks 0
scoreboard players set @s pvp.requested_id 0
scoreboard players set @s pvp.saved 0
scoreboard players add @s pvp.wins 0
scoreboard players add @s pvp.losses 0
scoreboard players enable @s pvp.trigger
scoreboard players enable @s pvp.request
scoreboard players enable @s pvp.accept
scoreboard players enable @s pvp.decline
scoreboard players enable @s pvp.cancel
scoreboard players enable @s pvp.help
scoreboard players enable @s pvp.stats
function pvp:vault_prepare
tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Tu as un identifiant PvP. Utilise ","color":"gray"},{"text":"/trigger pvp.trigger","color":"yellow","clickEvent":{"action":"run_command","value":"/trigger pvp.trigger"}},{"text":" pour ouvrir le menu.","color":"gray"}]
