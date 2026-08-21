# ============================================================
# end_duel.mcfunction
# ============================================================

# Cote gagnant : score, annonce publique, titre, son
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run scoreboard players add @s pvp.wins 1
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run tellraw @a [{"text":"\u2694 ","color":"gold"},{"selector":"@s"},{"text":" remporte le duel !","color":"yellow"}]
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run title @s title {"text":"VICTOIRE","color":"green","bold":true}
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run playsound minecraft:ui.toast.challenge_complete master @s

# Cote perdant : score, titre
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.loser] run scoreboard players add @s pvp.losses 1
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.loser] run title @s title {"text":"DEFAITE","color":"red","bold":true}

# Retour au lobby dans l'overworld — C'EST CE CHANGEMENT DE DIMENSION QUI
# DECLENCHE l'echange automatique d'inventaire (Dimensional Inventories
# detecte le changement de pool "pvp" -> "default" et restaure le stuff
# d'origine). Rester dans multiworld:pvp ne le declencherait PAS.
# A ADAPTER : mets tes coordonnees de lobby / spawn overworld
execute as @a[tag=pvp.duel] in minecraft:overworld run tp @s 0 100 0

execute as @a[tag=pvp.duel] run function potatopvp:cleanup_player

function potatopvp:reset_arena
scoreboard players set #global pvp.state 0
