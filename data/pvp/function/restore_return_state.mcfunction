# 1. Nettoyage du kit de duel
clear @s

# 2. Restauration de la position
$tp @s $(x) $(y) $(z) $(yaw) $(pitch)
$spawnpoint @s $(x) $(y) $(z)

# 3. Restauration de l'inventaire et du slot
$data modify entity @s Inventory set value $(Inventory)
$data modify entity @s SelectedItemSlot set value $(selected_slot)

# 4. Remise en forme du joueur
effect clear @s
effect give @s minecraft:instant_health 1 255 true
effect give @s minecraft:saturation 1 255 true