# ============================================================
# check_win.mcfunction — tourne chaque tick tant que pvp.state = 1 ou 2
# ============================================================

# --- Securite deconnexion : si un des 2 duellistes a quitte le
# serveur, il ne reste qu'un (ou zero) joueur tague pvp.duel.
# On annule proprement plutot que de laisser l'arene bloquee.
scoreboard players set #alive pvp.alive 0
execute as @a[tag=pvp.duel] run scoreboard players add #alive pvp.alive 1
execute if score #alive pvp.alive matches ..1 run tellraw @a [{"text":"[Duel] ","color":"dark_gray"},{"text":"Duel annule (deconnexion).","color":"gray"}]
execute if score #alive pvp.alive matches ..1 run function pvp:end_duel

# --- Victoire normale : le compteur de morts d'un joueur a
# augmente depuis le debut du duel -> il vient de mourir.
# (deathCount est une stat vanilla, pas besoin de la calculer nous-memes)
execute as @a[tag=pvp.duel] if score @s pvp.deaths > @s pvp.deaths_start run tag @s add pvp.loser
execute if entity @a[tag=pvp.loser] run function pvp:end_duel
