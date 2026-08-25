# Restore the exact place, spawn point and inventory the player had before
# entering the arena.
$tp @s $(x) $(y) $(z) $(yaw) $(pitch)
$spawnpoint @s $(x) $(y) $(z)
clear @s

data modify entity @s Inventory set from storage pvp:tmp.return.Inventory
execute store result entity @s SelectedItemSlot int 1 run data get storage pvp:tmp.return.selected_slot
