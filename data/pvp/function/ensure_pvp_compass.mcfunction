# Ensure every player keeps their PvP compass even if they throw it away.
# Also re-give it immediately after a datapack reload or reconnect.
execute if entity @s[nbt={Inventory:[{id:"minecraft:compass",tag:{pvp_menu:1b}}]}] run return 0
clear @s minecraft:compass{pvp_menu:1b}
give @s minecraft:compass{pvp_menu:1b,display:{Name:'{"text":"Menu PvP","color":"aqua","italic":false}'}}
