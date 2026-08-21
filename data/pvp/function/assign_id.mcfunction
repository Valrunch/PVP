# Contexte : exécuté "as" un joueur sans pvp.id (couvre les nouvelles
# connexions, vu qu'il n'existe pas de hook vanilla "on join").
scoreboard players add #next_id pvp.state 1
scoreboard players operation @s pvp.id = #next_id pvp.state
