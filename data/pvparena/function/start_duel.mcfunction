# ============================================================
# start_duel.mcfunction
# Contexte : pvp.slot1 / pvp.slot2 sont déjà posés par
# launch_from_request.mcfunction (un joueur par tag).
# ============================================================

tag @a[tag=pvp.slot1] add pvp.duel
tag @a[tag=pvp.slot2] add pvp.duel

# Capture le compteur de morts ACTUEL de chacun. C'est notre référence :
# check_win.mcfunction déclare perdant celui dont pvp.deaths dépasse
# cette valeur pendant le combat (= il vient de mourir).
execute as @a[tag=pvp.duel] run scoreboard players operation @s pvp.deaths_start = @s pvp.deaths

# Spawn dans la dimension PVP avec MultiWorld
execute as @a[tag=pvp.slot1] in pvp run tp @s 100 65 90 90 0
execute as @a[tag=pvp.slot2] in pvp run tp @s 100 65 110 -90 0

execute as @a[tag=pvp.duel] run function pvparena:prepare_player

scoreboard players set #global pvp.state 1
tellraw @a [{"text":"⚔ Duel lancé !","color":"red","bold":true}]
