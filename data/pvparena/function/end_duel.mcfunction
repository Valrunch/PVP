# ============================================================
# end_duel.mcfunction
# Retour au spawn de la dimension PVP
# ============================================================

# S'il y a un perdant désigné (mort en combat, pas une déconnexion),
# l'autre duelliste gagne un point et une annonce publique.
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run scoreboard players add @s pvp.wins 1
execute if entity @a[tag=pvp.loser] as @a[tag=pvp.duel,tag=!pvp.loser] run tellraw @a [{"text":"🏆 ","color":"gold"},{"selector":"@s"},{"text":" remporte le duel !","color":"yellow"}]

# Retour au spawn de la dimension PVP
execute as @a[tag=pvp.duel] in pvp:dimension run tp @s 0 64 0

execute as @a[tag=pvp.duel] run function pvparena:cleanup_player

function pvparena:reset_arena
scoreboard players set #global pvp.state 0
