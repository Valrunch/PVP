# ============================================================
# start_duel.mcfunction
# Contexte : pvp.slot1 / pvp.slot2 deja poses par launch_from_request.
# Dimension et coordonnees en dur (config validee : multiworld:pvp).
# ============================================================

tag @a[tag=pvp.slot1] add pvp.duel
tag @a[tag=pvp.slot2] add pvp.duel

# Save the exact place and facing direction before entering the duel arena.
# v1.0 : sauvegarde separee par slot (voir save_return_state.mcfunction) —
# sinon le 2e joueur ecrase les donnees du 1er (bug critique corrige).
execute as @a[tag=pvp.slot1] run function pvp:save_return_state {slot:1}
execute as @a[tag=pvp.slot2] run function pvp:save_return_state {slot:2}

# Reference pour la detection de victoire (voir check_win.mcfunction)
execute as @a[tag=pvp.duel] run scoreboard players operation @s pvp.deaths_start = @s pvp.deaths

# v1.0 : angle de vue remis (yaw/pitch avaient disparu lors du dernier
# deplacement de l'arene -> les duellistes pouvaient demarrer dos a
# dos). Les deux points sont separes surtout en X (150 vs 32, ~118
# blocs ; l'ecart en Z n'est que de 3) : slot1 (X le plus grand) doit
# regarder vers l'ouest (yaw 90) pour faire face a slot2, et slot2 (X
# le plus petit) vers l'est (yaw -90) pour faire face a slot1. Verifie
# en jeu que les deux se voient bien a l'arrivee — je n'ai pas pu le
# tester directement.
execute as @a[tag=pvp.slot1] in multiworld:pvp run tp @s 150 6.00 -139 90 0
execute as @a[tag=pvp.slot2] in multiworld:pvp run tp @s 32 6.00 -136 -90 0

execute as @a[tag=pvp.duel] run function pvp:prepare_player

# Resistance quasi totale le temps du decompte : personne ne peut
# taper avant "COMBATTEZ", equite garantie sans logique complexe.
# v1.0 : duree ramenee a 3s (au lieu de 4s) pour correspondre exactement
# a la duree reelle du decompte 3-2-1-GO (3 x 20 ticks = 3s, voir
# countdown_3/2/1/go.mcfunction, inchanges). Avec 4s, les deux joueurs
# restaient quasi invincibles 1 seconde APRES l'affichage "COMBATTEZ".
execute as @a[tag=pvp.duel] run effect give @s minecraft:resistance 3 255 true

# Nettoyage des compteurs de decompte deja planifies par un ancien duel.
# Sinon un ancien evenement peut still s'executer plus tard et lancer un
# faux "Duel lance !" ou modifier l'etat du combat pendant un autre duel.
schedule clear pvp:countdown_2
schedule clear pvp:countdown_1
schedule clear pvp:countdown_go

scoreboard players set #global pvp.state 2
function pvp:countdown_3
