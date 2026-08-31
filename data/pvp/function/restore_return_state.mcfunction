# Restore the exact place, spawn point and inventory the player had before entering the arena.
$tp @s $(x) $(y) $(z) $(yaw) $(pitch)
$spawnpoint @s $(x) $(y) $(z)

# Soin et nettoyage pour éviter la mort instantanée au retour
effect clear @s
effect give @s minecraft:instant_health 1 255 true
effect give @s minecraft:saturation 1 255 true