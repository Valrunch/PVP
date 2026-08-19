# ============================================================
# reset_arena.mcfunction
# ⚠️ 1 ligne à adapter (dimension + coordonnées d'ancrage), voir README
# ============================================================
# Pré-requis : avoir sauvegardé ta zone de combat avec un Structure
# Block (mode SAVE, nom exact "pvparena:arena") AVANT le premier duel.
# "place template" est 100% vanilla : aucune dépendance à WorldEdit
# pour le reset auto, donc aucun risque de conflit avec ton stack de mods.

execute in TON_NS:TA_DIM run place template pvparena:arena 90 60 80
