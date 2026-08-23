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
# ============================================================

execute in multiworld:pvp run place template pvp:arena 90 60 80
