# Contexte : execute "as" chaque duelliste
# Mode Adventure : empeche de casser/poser des blocs (protection anti-
# grief de l'arene) SANS bloquer les degats subis par le joueur (chute,
# feu, lave...). Les explosions, le feu et la lave continuent de modifier
# les blocs normalement : ce sont des mecaniques globales du monde, pas
# liees au gamemode d'un joueur precis. Si tu ajoutes plus tard un item
# du kit qui pose des blocs (seau, TNT, briquet...), il faudra lui donner
# les tags NBT CanPlaceOn/CanDestroy pour qu'il fonctionne en Adventure.
gamemode adventure @s
# Retire explicitement l'item menu pour eviter qu'il reste dans l'inventaire
# pendant un duel et qu'il soit duplique / conserve accidentalement.
clear @s minecraft:diamond_sword[custom_data={pvp_menu:true}]
clear @s
effect clear @s
effect give @s minecraft:instant_health 1 250
function pvp:give_kit
