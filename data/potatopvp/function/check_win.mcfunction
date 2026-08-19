# ============================================================
# check_win.mcfunction — tourne chaque tick tant que pvp.state = 1
# ============================================================

# --- Sécurité déconnexion : si un des 2 duellistes a quitté le
# serveur, il ne reste qu'un (ou zéro) joueur tagué pvp.duel.
# On annule proprement plutôt que de laisser l'arène bloquée.
scoreboard players set #alive pvp.state 0
execute as @a[tag=pvp.duel] run scoreboard players add #alive pvp.state 1
execute if score #alive pvp.state matches ..1 run tellraw @a [{"text":"Duel annulé (déconnexion).","color":"gray"}]
execute if score #alive pvp.state matches ..1 run function potatopvp:end_duel

# --- Victoire normale : le compteur de morts d'un joueur a
# augmenté depuis le début du duel -> il vient de mourir.
# (deathCount est une stat vanilla, pas besoin de la calculer nous-mêmes)
execute as @a[tag=pvp.duel] if score @s pvp.deaths > @s pvp.deaths_start run tag @s add pvp.loser
execute if entity @a[tag=pvp.loser] run function potatopvp:end_duel
