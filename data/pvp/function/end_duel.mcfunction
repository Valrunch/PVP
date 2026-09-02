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

# Retour au lobby dans l'overworld
# On téléporte d'abord pour sortir de la dimension PvP
execute as @a[tag=pvp.duel] in minecraft:overworld run tp @s 0 100 0

# On soigne IMMÉDIATEMENT pour éviter la mort au respawn (surtout pour le perdant)
execute as @a[tag=pvp.duel] run effect give @s minecraft:instant_health 1 255 true
execute as @a[tag=pvp.duel] run effect give @s minecraft:saturation 1 255 true

# On restaure l'inventaire et la position précise
execute as @a[tag=pvp.slot1] run function pvp:restore_return_state with storage pvp:tmp.return1
execute as @a[tag=pvp.slot2] run function pvp:restore_return_state with storage pvp:tmp.return2

# On s'assure que keepInventory est actif pendant la restauration
gamerule keepInventory true

# On désactive keepInventory seulement après que tout le monde soit stabilisé
# On utilise un schedule pour laisser le temps au serveur de traiter le TP et la restauration
schedule function pvp:disable_keepinventory 1t

# Nettoie les compteurs de decompte encore planifies. Sans cela, un ancien
# compte a rebours peut encore s'executer apres la fin d'un duel et
# reinitialiser l'etat du combat sur un autre match.
schedule clear pvp:countdown_2
schedule clear pvp:countdown_1
schedule clear pvp:countdown_go

# Restore the exact previous position and spawn point before the duel.
# v1.0 : chaque joueur relit SA propre cle de stockage (pvp:tmp.return1 /
# return2) — fixe le bug critique ou les deux duellistes recevaient la
# meme position/inventaire (celui du dernier sauvegarde par start_duel).
# (Déplacé plus haut dans end_duel.mcfunction pour garantir la restauration avant keepInventory=false)

# Récompense pour le vainqueur (exécutée APRES la restauration de l'inventaire de survie)
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run give @s cobblemon:exp_candy_xs 10

execute as @a[tag=pvp.duel] run function pvp:cleanup_player

function pvp:reset_arena
scoreboard players set #global pvp.state 0
