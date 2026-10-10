$execute unless data storage pvp:stats h2h.p$(id)[0] run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Aucun duel joue pour l'instant.","color":"gray"}]
tellraw @s [{"text":"Contre chaque joueur :","color":"gold"}]
$data modify storage pvp:tmp list set from storage pvp:stats h2h.p$(id)
function pvp:show_stats_loop
