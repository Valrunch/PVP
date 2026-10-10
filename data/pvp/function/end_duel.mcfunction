execute if entity @a[tag=pvp.loser] if entity @a[tag=pvp.duel,tag=!pvp.loser] run function pvp:record_result
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run function pvp:win_duel
execute as @a[tag=pvp.loser] run function pvp:lose_duel
execute if entity @a[tag=pvp.loser] unless entity @a[tag=pvp.duel,tag=!pvp.loser] run tellraw @a [{"text":"[Duel] ","color":"dark_gray"},{"text":"Egalite : les deux joueurs sont morts.","color":"yellow"}]
schedule clear pvp:countdown_2
schedule clear pvp:countdown_1
schedule clear pvp:countdown_go
tag @a[tag=pvp.duel] remove pvp.duel
tag @a[tag=pvp.slot1] remove pvp.slot1
tag @a[tag=pvp.slot2] remove pvp.slot2
tag @a[tag=pvp.loser] remove pvp.loser
function pvp:reset_arena
scoreboard players set #global pvp.state 0
