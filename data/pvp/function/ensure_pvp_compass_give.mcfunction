# Enlever toute copie du menu qui traine au sol pour eviter les duplications.
kill @e[type=item,nbt={Item:{id:"minecraft:fishing_rod",components:{"minecraft:custom_data":{pvp_menu:true}}}}]

# Supprimer toute version du menu deja presente dans l'inventaire pour eviter les doublons.
clear @s minecraft:fishing_rod[custom_data={pvp_menu:true}]

# On revient a l'item simple et fiable : la canne a peche avec un tag custom_data.
execute unless items entity @s container.* minecraft:fishing_rod[custom_data={pvp_menu:true}] run give @s minecraft:fishing_rod[custom_data={pvp_menu:true},custom_name='{"text":"Menu PvP","color":"aqua","italic":false}',lore=['{"text":"Clic droit pour ouvrir le menu PvP","color":"gray"}']]