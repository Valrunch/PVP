# ============================================================
# reset_arena.mcfunction
# Reset automatique de l'arène après chaque duel
# Utilise la dimension PVP avec MultiWorld
# ============================================================
# Pré-requis : avoir sauvegardé ta zone de combat avec un Structure
# Block (mode SAVE, nom exact "pvparena:arena") AVANT le premier duel.
# "place template" est 100% vanilla : aucune dépendance à WorldEdit
# pour le reset auto, donc aucun risque de conflit avec ton stack de mods.

execute in pvp run place template pvparena:arena 90 60 80
