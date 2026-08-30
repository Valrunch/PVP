# ============================================================
# reset_arena.mcfunction
# Necessite d'avoir sauvegarde l'arene via un Structure Block
# (mode SAVE, nom exact "pvp:arena") avant le premier duel.
# 100% vanilla, aucune dependance a WorldEdit pour le reset auto.
#
# Limite connue : si un incendie se propage HORS des limites de la
# structure sauvegardee (herbe, arbres autour de l'arene...), ce reset
# ne les restaure pas. A garder en tete si l'arene autorise des sources
# de feu qui peuvent deborder de sa zone.
#
# v1.0 : nettoyage des entites "item" et "experience_orb" restantes
# dans la dimension AVANT le reset des blocs. Sans ca, l'equipement du
# perdant (epee, armure...) restait au sol apres le reset et pouvait
# etre recupere par le joueur suivant (fuite de loot entre duels).
# ============================================================

execute in multiworld:pvp run kill @e[type=item]
execute in multiworld:pvp run kill @e[type=experience_orb]
execute in multiworld:pvp run place template pvp:arena 90 60 80
