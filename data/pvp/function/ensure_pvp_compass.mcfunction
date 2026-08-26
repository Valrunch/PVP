# Ensure every player keeps their PvP menu item even if they throw it away.
# We use a stick-based item instead of a real compass because plain compasses
# trigger vanilla right-click behavior (pointing/teleporting) on 1.21.
clear @s minecraft:warped_fungus_on_a_stick{pvp_menu:1b}
clear @s minecraft:compass{pvp_menu:1b}
give @s minecraft:warped_fungus_on_a_stick{pvp_menu:1b,display:{Name:'{"text":"Menu PvP","color":"aqua","italic":false}'}}
