# ============================================================
# reset_arena.mcfunction
# Necessite d'avoir sauvegarde l'arene via un Structure Block
# (mode SAVE, nom exact "potatopvp:arena") avant le premier duel.
# 100% vanilla, aucune dependance a WorldEdit pour le reset auto.
# ============================================================

execute in pvp:dimension run place template potatopvp:arena 90 60 80
