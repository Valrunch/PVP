# Ensure every player keeps their PvP compass even if they throw it away.
# Use the modern item-component syntax that matches 1.21 command parsing.
clear @s minecraft:compass[custom_data={pvp_menu:1b}]
give @s minecraft:compass[custom_name='{"text":"Menu PvP","color":"aqua","italic":false}',custom_data={pvp_menu:1b}]
