# Contexte : execute "as" un joueur sans pvp.id (couvre les nouvelles
# connexions, vu qu'il n'existe pas de hook vanilla "on join").
# L'ID est attribue depuis un compteur global unique : chaque nouveau joueur
# reçoit un nombre strictement superieur au precedent, ce qui evite les doublons.
scoreboard players add #next_id pvp.nextid 1
scoreboard players operation @s pvp.id = #next_id pvp.nextid

tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Tu as un identifiant PvP. Utilise /trigger pvp.trigger pour ouvrir le menu.","color":"gray"}]
