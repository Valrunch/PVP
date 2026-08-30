# ============================================================
# load.mcfunction — tourne une fois au chargement du datapack
# "add" est idempotent : ne recree pas l'objectif s'il existe deja,
# donc /reload ne casse jamais les scores en cours (sauf pvp.state,
# volontairement remis a 0 : voir note en bas de fichier).
# ============================================================

scoreboard objectives add pvp.state dummy
scoreboard objectives add pvp.nextid dummy
scoreboard objectives add pvp.candidates dummy
scoreboard objectives add pvp.alive dummy
scoreboard objectives add pvp.deaths deathCount
scoreboard objectives add pvp.deaths_start dummy
scoreboard objectives add pvp.wins dummy "PvP Wins"
scoreboard objectives add pvp.losses dummy "PvP Losses"
scoreboard objectives add pvp.stats trigger "Voir mes stats PvP"

# Identite stable par joueur (independante du pseudo), attribuee
# une fois pour toutes via assign_id.mcfunction.
scoreboard objectives add pvp.id dummy

# pvp.trigger / pvp.request / pvp.accept / pvp.decline / pvp.cancel / pvp.help
# sont des objectifs "trigger" : n'importe quel joueur peut faire
# /trigger <objectif>, meme sans etre op. On les active automatiquement
# pour chaque joueur pour garder le systeme plus simple et plus intuitif.
scoreboard objectives add pvp.trigger trigger "Ouvrir le menu pour le pvp"
scoreboard objectives add pvp.request trigger "Defier un joueur"
scoreboard objectives add pvp.accept trigger "Accepter un duel"
scoreboard objectives add pvp.decline trigger "Refuser un duel"
scoreboard objectives add pvp.cancel trigger "Annuler ta demande envoyee"
scoreboard objectives add pvp.help trigger "Afficher les commandes"
scoreboard objectives add pvp.pending_from dummy
scoreboard objectives add pvp.pendingticks dummy
scoreboard objectives add pvp.requested_id dummy

# Activation directe des triggers, sans setup pour les joueurs normaux.
scoreboard players enable @a pvp.trigger
scoreboard players enable @a pvp.request
scoreboard players enable @a pvp.accept
scoreboard players enable @a pvp.decline
scoreboard players enable @a pvp.cancel
scoreboard players enable @a pvp.help
scoreboard players enable @a pvp.stats

# #global, #next_id, #candidates et #alive sont des "fake players"
# (pas de vrais joueurs), juste des variables globales pour eviter
# de dupliquer l'etat.
#
# NOTE : #global pvp.state est remis a 0 (arene libre) a chaque
# chargement. Si tu fais /reload PENDANT un duel en cours, ce duel
# sera casse (l'arene ne se reinitialisera pas toute seule). Evite
# de recharger le datapack pendant un combat actif.
scoreboard players set #global pvp.state 0

# v1.0 : "set ... 0" a ete remis en "add ... 0" (no-op qui preserve la
# valeur existante). BUG CRITIQUE corrige : la version precedente
# remettait le compteur ET le pvp.id de chaque joueur EN LIGNE a 0 a
# chaque /reload, puis les reassignait a partir de 1 — mais un joueur
# DECONNECTE a ce moment-la gardait son ancien ID. Exemple concret :
# JoueurA (id=1) se deconnecte, JoueurB (id=2) reste connecte. Un
# /reload remet JoueurB a 0 puis lui donne le nouvel id=1 -> JoueurA
# ET JoueurB ont maintenant TOUS LES DEUX l'id=1. Toute demande de duel
# ciblant l'un touche alors l'autre en meme temps (selecteurs
# @a[scores={pvp.id=1}] ambigus partout : notifications, tags,
# teleportations...). Un compteur qui ne fait qu'augmenter, jamais
# reinitialise, est la seule facon d'eviter ca de façon fiable — c'est
# d'ailleurs exactement l'invariant que decrit le commentaire
# d'assign_id.mcfunction ("chaque nouveau joueur recoit un nombre
# strictement superieur au precedent").
scoreboard players add #next_id pvp.nextid 0

# Nettoie les tags PvP fantomes qui peuvent rester apres un bug / tp casse.
# Ces etats sont transitoires (contrairement a pvp.id, qui doit rester
# stable) : les reinitialiser au reload est sans risque.
execute as @a run tag @s remove pvp.duel
execute as @a run tag @s remove pvp.slot1
execute as @a run tag @s remove pvp.slot2
execute as @a run tag @s remove pvp.loser
execute as @a run scoreboard players set @s pvp.request 0
execute as @a run scoreboard players set @s pvp.requested_id 0
execute as @a run scoreboard players set @s pvp.pending_from 0
execute as @a run scoreboard players set @s pvp.pendingticks 0

# v1.0 : ne touche plus a pvp.id des joueurs deja connectes (voir note
# ci-dessus) — seuls les joueurs qui n'en ont jamais eu (id absent /
# < 1, donc les vraies nouvelles connexions) passent par assign_id.
execute as @a unless score @s pvp.id matches 1.. run function pvp:assign_id

tellraw @a [{"text":"[potatoPVP v1.0] datapack charge.","color":"dark_gray"}]
