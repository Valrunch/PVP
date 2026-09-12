# ============================================================
# end_duel.mcfunction
# v1.1 - FIX RESPAWN : on ne restaure (tp, dimension, inventaire, gamemode)
# un duelliste QUE s'il est reellement vivant (score pvp.health >= 1) au
# moment ou cette fonction tourne. Un joueur mort (ecran de mort) ne peut
# pas etre deplace de facon fiable entre dimensions par une commande /tp,
# et de toute facon le respawn vanilla efface les effets qu'on lui donnerait
# pendant qu'il est encore mort - exactement le probleme deja identifie et
# corrige pour les effets de potion (voir postduel_shield.mcfunction).
# Avant ce fix, le PERDANT (toujours mort a cet instant precis) recevait ce
# meme traitement immediat que le gagnant : c'est tres probablement la
# cause du "respawn qui marche mal" (feu qui persiste, faim mal restauree,
# objets parfois perdus).
# Le perdant est desormais fini plus tard, au moment exact ou son vrai
# respawn est detecte : voir tick.mcfunction, meme bloc que le rattrapage
# de reconnexion - c'est litteralement le meme cas de figure (un joueur
# tague pvp.duel qui doit encore etre restaure).
# ============================================================

# Cote gagnant : score, annonce publique, titre, son
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run scoreboard players add @s pvp.wins 1
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run tellraw @a [{"text":"[Duel] ","color":"dark_gray"},{"selector":"@s"},{"text":" remporte le duel !","color":"yellow"}]
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run title @s title {"text":"VICTOIRE","color":"green","bold":true}
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run playsound minecraft:ui.toast.challenge_complete master @s

# Cote perdant : score, titre (sans risque meme mort, aucun impact sur la position)
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.loser] run scoreboard players add @s pvp.losses 1
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.loser] run title @s title {"text":"DEFAITE","color":"red","bold":true}

# Nettoie les compteurs de decompte encore planifies. Sans cela, un ancien
# compte a rebours peut encore s'executer apres la fin d'un duel et
# reinitialiser l'etat du combat sur un autre match.
schedule clear pvp:countdown_2
schedule clear pvp:countdown_1
schedule clear pvp:countdown_go

# --- Restauration immediate : uniquement les duellistes VIVANTS ---
# Cas normal : c'est le gagnant. Cas annulation pour deconnexion (voir
# check_win.mcfunction) : c'est le joueur reste en ligne, tant qu'il est
# vivant lui aussi. Chaque joueur relit SA propre cle de stockage
# (pvp:tmp.return1 / return2) - fixe le bug critique ou les deux
# duellistes recevaient la meme position/inventaire.
execute as @a[tag=pvp.duel,tag=pvp.slot1,scores={pvp.health=1..}] run function pvp:restore_return_state with storage pvp:tmp.return1
execute as @a[tag=pvp.duel,tag=pvp.slot2,scores={pvp.health=1..}] run function pvp:restore_return_state with storage pvp:tmp.return2

# Recompense pour le vainqueur (executee APRES la restauration de l'inventaire de survie)
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run give @s cobblemon:exp_candy_xs 10

execute as @a[tag=pvp.duel,scores={pvp.health=1..}] run function pvp:cleanup_player

# Le perdant mort n'est PAS touche ici : il garde pvp.duel + pvp.loser +
# son tag de slot jusqu'a son vrai respawn. tick.mcfunction detecte ce
# moment (pvp.health repasse a 1..) et termine alors sa restauration.

# BUG DE SECURITE corrige - keepInventory est mis a "true" au debut
# de CHAQUE duel (start_duel.mcfunction) mais n'etait JAMAIS remis a "false".
# Comme /gamerule est un reglage GLOBAL (pas limite a une dimension), des
# le tout premier duel, TOUS les joueurs du serveur, PARTOUT, cessaient de
# perdre leur inventaire en mourant - y compris hors de l'arene, pour de bon.
# On le desactive donc explicitement ici, a chaque fin de duel. Sans risque
# de le faire tout de suite meme si le perdant n'a pas encore respawn : la
# decision garder/perdre l'inventaire se prend au moment de la MORT, pas
# du respawn.
gamerule keepInventory false

function pvp:reset_arena
scoreboard players set #global pvp.state 0
