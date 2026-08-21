# ============================================================
# start_duel.mcfunction
# Contexte : pvp.slot1 / pvp.slot2 deja poses par launch_from_request.
# Dimension et coordonnees en dur (config validee : multiworld:pvp).
# ============================================================

tag @a[tag=pvp.slot1] add pvp.duel
tag @a[tag=pvp.slot2] add pvp.duel

# Reference pour la detection de victoire (voir check_win.mcfunction)
execute as @a[tag=pvp.duel] run scoreboard players operation @s pvp.deaths_start = @s pvp.deaths

execute as @a[tag=pvp.slot1] in multiworld:pvp run tp @s 100 65 90 90 0
execute as @a[tag=pvp.slot2] in multiworld:pvp run tp @s 100 65 110 -90 0

execute as @a[tag=pvp.duel] run function pvp:prepare_player

# Resistance quasi totale le temps du decompte : personne ne peut
# taper avant "COMBATTEZ", equite garantie sans logique complexe.
execute as @a[tag=pvp.duel] run effect give @s minecraft:resistance 4 255 true

scoreboard players set #global pvp.state 2
function pvp:countdown_3
