# ============================================================
# end_duel.mcfunction
# ============================================================

# Cote gagnant : score, annonce publique, titre, son
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run scoreboard players add @s pvp.wins 1
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run tellraw @a [{"text":"[Duel] ","color":"dark_gray"},{"selector":"@s"},{"text":" remporte le duel !","color":"yellow"}]
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run title @s title {"text":"VICTOIRE","color":"green","bold":true}
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run playsound minecraft:ui.toast.challenge_complete master @s

# Cote perdant : score, titre
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.loser] run scoreboard players add @s pvp.losses 1
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.loser] run title @s title {"text":"DEFAITE","color":"red","bold":true}

# Retour au lobby dans l'overworld — C'EST CE CHANGEMENT DE DIMENSION QUI
# DECLENCHE l'echange automatique d'inventaire (Dimensional Inventories
# detecte le changement de pool "pvp" -> "default" et restaure le stuff
# d'origine). Rester dans multiworld:pvp ne le declencherait PAS.
execute as @a[tag=pvp.duel] in minecraft:overworld run tp @s 0 100 0

# Nettoie les compteurs de decompte encore planifies. Sans cela, un ancien
# compte a rebours peut encore s'executer apres la fin d'un duel et
# reinitialiser l'etat du combat sur un autre match.
schedule clear pvp:countdown_2
schedule clear pvp:countdown_1
schedule clear pvp:countdown_go

# Restore the exact previous position and spawn point before the duel.
execute as @a[tag=pvp.duel] run function pvp:restore_return_state with storage pvp:tmp.return

execute as @a[tag=pvp.duel] run function pvp:cleanup_player

function pvp:reset_arena
scoreboard players set #global pvp.state 0
