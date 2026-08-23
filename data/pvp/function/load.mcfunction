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
scoreboard objectives add pvp.trigger trigger "Ouvrir le menu de defi"
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
scoreboard players add #next_id pvp.nextid 0

tellraw @a [{"text":"[potatoPVP v1.3] datapack charge.","color":"dark_gray"}]
