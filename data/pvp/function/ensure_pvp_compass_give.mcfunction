# Enlever toute copie du menu qui traine au sol pour eviter les duplications.
kill @e[type=item,nbt={Item:{id:"minecraft:diamond_sword",components:{"minecraft:custom_data":{pvp_menu:true}}}}]

# Supprimer toute version du menu deja presente dans l'inventaire pour eviter les doublons.
clear @s minecraft:diamond_sword[custom_data={pvp_menu:true}]

# On garde l'item dans le bon format vanilla (epée en diamant) mais on remplace
# le visuel par un model custom dans le resource pack. Cela garde la compatibilite
# 1.21.1 et la logique de clic droit sans pop/depop.
execute unless items entity @s container.* minecraft:diamond_sword[custom_data={pvp_menu:true}] run give @s minecraft:diamond_sword[custom_model_data=1,custom_data={pvp_menu:true},custom_name='{"text":"Menu PvP","color":"#00E5FF","italic":false}',lore=['{"text":"Clic droit pour ouvrir le menu PvP","color":"gray"}']]