# Ensure every player keeps their PvP menu item even if they throw it away.
# We use a right-click-safe item instead of a compass because vanilla compasses
# trigger their own behavior on 1.21 when used.
clear @s minecraft:warped_fungus_on_a_stick[custom_data={pvp_menu:1b}]
clear @s minecraft:compass[custom_data={pvp_menu:1b}]
give @s minecraft:warped_fungus_on_a_stick[custom_name='{"text":"Menu PvP","color":"aqua","italic":false}',custom_data={pvp_menu:1b}]
