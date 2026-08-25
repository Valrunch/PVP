# Contexte : execute "as" un joueur sans pvp.id (couvre les nouvelles
# connexions, vu qu'il n'existe pas de hook vanilla "on join").
# C'est aussi ici, et seulement ici, qu'un joueur est vraiment "nouveau" :
# on lui donne une boussole qui ouvre le menu PvP en un clic droit, pour
# qu'il n'ait meme pas besoin de connaitre la commande /trigger.
scoreboard players add #next_id pvp.nextid 1
scoreboard players operation @s pvp.id = #next_id pvp.nextid
function pvp:ensure_pvp_compass

tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Tu as recu une boussole PvP : clic droit dessus pour ouvrir le menu de duel.","color":"gray"}]
