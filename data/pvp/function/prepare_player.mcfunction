# Contexte : execute "as" chaque duelliste
# Mode Adventure : empeche de casser/poser des blocs (protection anti-
# grief de l'arene) SANS bloquer les degats subis par le joueur (chute,
# feu, lave...). Les explosions, le feu et la lave continuent de modifier
# les blocs normalement : ce sont des mecaniques globales du monde, pas
# liees au gamemode d'un joueur precis. Si tu ajoutes plus tard un item
# du kit qui pose des blocs (seau, TNT, briquet...), il faudra lui donner
# les tags NBT CanPlaceOn/CanDestroy pour qu'il fonctionne en Adventure.
gamemode adventure @s
clear @s
effect clear @s
effect give @s minecraft:instant_health 1 250
function pvp:give_kit
