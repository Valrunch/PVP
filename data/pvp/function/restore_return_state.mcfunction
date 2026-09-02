# 1. Restauration de la position
# On utilise tp sans $ pour être sûr de la compatibilité si $(x) etc sont mal interprétés
tp @s $(x) $(y) $(z) $(yaw) $(pitch)
spawnpoint @s $(x) $(y) $(z)

# 2. Restauration de l'inventaire
# On vide l'inventaire PvP
clear @s
# Restauration via storage
data modify entity @s Inventory set from storage pvp:tmp.return$(slot) Inventory
execute store result entity @s SelectedItemSlot int 1 run data get storage pvp:tmp.return$(slot) selected_slot

# 3. Soin et nettoyage des effets
effect clear @s
effect give @s minecraft:instant_health 1 255 true
effect give @s minecraft:saturation 1 255 true