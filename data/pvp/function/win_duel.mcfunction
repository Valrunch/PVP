scoreboard players add @s pvp.wins 1
tag @s add pvp.reward
tellraw @a [{"text":"[Duel] ","color":"dark_gray"},{"selector":"@s","color":"yellow"},{"text":" a battu ","color":"gray"},{"selector":"@a[tag=pvp.loser,limit=1]","color":"yellow"},{"text":" en duel !","color":"gray"}]
title @s subtitle [{"text":"contre ","color":"gray"},{"selector":"@a[tag=pvp.loser,limit=1]","color":"yellow"}]
title @s title {"text":"VICTOIRE","color":"green","bold":true}
playsound minecraft:ui.toast.challenge_complete master @s
