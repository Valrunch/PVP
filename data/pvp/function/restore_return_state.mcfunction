# lignes remises (avaient ete supprimees par erreur dans le commit
# "Refactor cleanup and restoration logic in duel functions" du 01/09).
# BUG CRITIQUE identifie : sans les etapes 1 et 3, le joueur ne recuperait
# ni le nettoyage de son kit de duel, ni son inventaire d'avant duel - il
# gardait juste ce qu'il avait sur lui au moment de la mort/fin du duel.
# Ce systeme est 100% manuel (pas de mod de separation d'inventaire par
# dimension sur ce serveur) : c'est ce fichier, et lui seul, qui doit
# remettre position ET inventaire en place a la fin du duel.

# 1. Nettoyage du kit de duel
clear @s

# 2. Restauration de la position
$tp @s $(x) $(y) $(z) $(yaw) $(pitch)
$spawnpoint @s $(x) $(y) $(z)

# 3. Restauration de l'inventaire et du slot selectionne
# IMPORTANT : "set from storage ... Inventory" (copie NBT directe), PAS
# "set value $(Inventory)". La 2e forme passe tout l'inventaire par une
# substitution de macro : Minecraft le convertit en texte pour l'inserer
# dans la commande, avant de le reparser. Avec Cobblemon installe, une
# seule Poke Ball contenant un Pokemon capture (espece, IVs, EVs, moves,
# nature, forme...) peut suffire a faire depasser la limite de longueur
# d'une commande - la ligne echoue alors SILENCIEUSEMENT (le reste de la
# fonction continue normalement), et comme clear @s vient juste de tout
# vider, le joueur se retrouve avec un inventaire vide. "set from storage"
# fait une copie NBT interne, jamais convertie en texte : aucune limite de
# taille, peu importe ce que contient l'inventaire.
$data modify entity @s Inventory set from storage pvp:tmp.return$(slot) Inventory
$data modify entity @s SelectedItemSlot set value $(selected_slot)

# 4. Soin et nettoyage des effets
effect clear @s
effect give @s minecraft:instant_health 1 255 true
effect give @s minecraft:saturation 1 255 true

# 5. Marqueur pour la vraie protection post-respawn (voir postduel_shield.mcfunction)
# Les effets donnes ci-dessus, s'ils sont donnes pendant que le joueur est
# ENCORE mort (cas du perdant, avant qu'il ait clique sur Respawn), sont
# perdus : le respawn vanilla reinitialise les effets actifs. Ce tag permet
# de reappliquer la protection au bon moment, une fois le joueur reellement
# vivant (voir tick.mcfunction).
tag @s add pvp.postduel_shield