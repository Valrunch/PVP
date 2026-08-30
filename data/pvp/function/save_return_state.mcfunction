# Save the exact pre-duel position, rotation and inventory so the player can
# be returned to the exact previous state after the duel, without depending on
# an external dimensional-inventory plugin.
# v1.0 : cle de stockage par slot ($(slot) = 1 ou 2). Avant, les deux
# duellistes ecrivaient dans la MEME cle "pvp:tmp.return" -> le 2e "save"
# ecrasait le 1er, et au retour les DEUX joueurs recevaient la position ET
# l'inventaire du meme joueur (celui sauvegarde en dernier). Bug critique
# corrige : voir restore_return_state.mcfunction et start_duel.mcfunction.
$execute store result storage pvp:tmp.return$(slot) x double 1 run data get entity @s Pos[0]
$execute store result storage pvp:tmp.return$(slot) y double 1 run data get entity @s Pos[1]
$execute store result storage pvp:tmp.return$(slot) z double 1 run data get entity @s Pos[2]
$execute store result storage pvp:tmp.return$(slot) yaw float 1 run data get entity @s Rotation[0]
$execute store result storage pvp:tmp.return$(slot) pitch float 1 run data get entity @s Rotation[1]
$execute store result storage pvp:tmp.return$(slot) selected_slot int 1 run data get entity @s SelectedItemSlot

$data modify storage pvp:tmp.return$(slot) Inventory set from entity @s Inventory
