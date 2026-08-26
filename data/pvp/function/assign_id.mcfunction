# Contexte : execute "as" un joueur sans pvp.id (couvre les nouvelles
# connexions, vu qu'il n'existe pas de hook vanilla "on join").
# C'est aussi ici, et seulement ici, qu'un joueur est vraiment "nouveau".
# On lui attribue un identifiant et il utilisera la commande /trigger pvp.trigger.
scoreboard players add #next_id pvp.nextid 1
scoreboard players operation @s pvp.id = #next_id pvp.nextid

tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Tu as un identifiant PvP. Utilise /trigger pvp.trigger pour ouvrir le menu.","color":"gray"}]
