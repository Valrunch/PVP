# Restore the exact place, spawn point and inventory the player had before
# entering the arena.
# v1.0 : entierement pilote par macro ($(x), $(Inventory), ...) fournie par
# l'appelant via "with storage pvp:tmp.returnN" — plus aucune cle de stockage
# fixee en dur ici, donc plus de risque de melange entre les deux duellistes
# (voir save_return_state.mcfunction).
$tp @s $(x) $(y) $(z) $(yaw) $(pitch)
$spawnpoint @s $(x) $(y) $(z)
clear @s

$data modify entity @s Inventory set value $(Inventory)
$data modify entity @s SelectedItemSlot set value $(selected_slot)
