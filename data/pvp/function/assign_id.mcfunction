# Contexte : execute "as" un joueur sans pvp.id (couvre les nouvelles
# connexions, vu qu'il n'existe pas de hook vanilla "on join").
# L'ID est attribue depuis un compteur global unique : chaque nouveau joueur
# reçoit un nombre strictement superieur au precedent, ce qui evite les doublons.
scoreboard players add #next_id pvp.nextid 1
scoreboard players operation @s pvp.id = #next_id pvp.nextid


scoreboard players enable @s pvp.trigger
scoreboard players enable @s pvp.request
scoreboard players enable @s pvp.accept
scoreboard players enable @s pvp.decline
scoreboard players enable @s pvp.cancel
scoreboard players enable @s pvp.help
scoreboard players enable @s pvp.stats


tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Tu as un identifiant PvP. Utilise ","color":"gray"},{"text":"/trigger pvp.trigger","color":"yellow","clickEvent":{"action":"run_command","value":"/trigger pvp.trigger"}},{"text":" pour ouvrir le menu.","color":"gray"}]
