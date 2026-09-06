# Contexte : execute "as" un joueur qui porte encore le tag pvp.postduel_shield
# ET dont le score pvp.health vient de repasser a 1 ou plus (voir le check
# dans tick.mcfunction). C'est ICI, et seulement ICI, qu'on sait avec
# certitude que le joueur est reellement vivant - pas juste teleporte pendant
# qu'il etait encore mort.
tag @s remove pvp.postduel_shield

# Resistance courte mais quasi-totale : protege contre une mort immediate
# (suffocation dans un bloc, chute residuelle...) si l'endroit ou il
# reapparait s'avere dangereux au moment exact du respawn.
effect give @s minecraft:resistance 3 255 true
effect give @s minecraft:instant_health 1 255 true
effect give @s minecraft:saturation 1 255 true

# Extinction reelle du feu, pas juste une immunite temporaire : le
# compteur de combustion ("Fire" en NBT) peut etre plus long que les
# quelques secondes de fire_resistance ci-dessous - une fois l'effet
# fini, s'il reste du temps de combustion, le feu reprend. On met donc
# le compteur a 0 directement (extinction immediate et definitive), la
# fire_resistance n'etant qu'une securite supplementaire le temps que ca
# s'applique.
data merge entity @s {Fire:0}
effect give @s minecraft:fire_resistance 3 0 true
