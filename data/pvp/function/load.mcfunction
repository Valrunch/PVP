# ============================================================
# load.mcfunction — tourne une fois au chargement du datapack
# "add" est idempotent : ne recrée pas l'objectif s'il existe déjà,
# donc /reload ne casse jamais les scores en cours.
# ============================================================

scoreboard objectives add pvp.state dummy
scoreboard objectives add pvp.deaths deathCount
scoreboard objectives add pvp.deaths_start dummy
scoreboard objectives add pvp.wins dummy "PvP Wins"
scoreboard objectives add pvp.losses dummy "PvP Losses"
scoreboard objectives add pvp.stats trigger "Voir mes stats PvP"

# Identité stable par joueur (indépendante du pseudo), attribuée
# une fois pour toutes via assign_id.mcfunction.
scoreboard objectives add pvp.id dummy

# pvp.trigger / pvp.request / pvp.accept / pvp.decline sont des
# objectifs "trigger" : n'importe quel joueur peut faire /trigger
# <objectif>, même sans être op. On les active automatiquement pour
# chaque joueur pour garder le système plus simple et plus intuitif.
scoreboard objectives add pvp.trigger trigger "Ouvrir le menu de défi"
scoreboard objectives add pvp.request trigger "Défier un joueur"
scoreboard objectives add pvp.accept trigger "Accepter un duel"
scoreboard objectives add pvp.decline trigger "Refuser un duel"
scoreboard objectives add pvp.pending_from dummy

# Enabling direct /trigger use without extra setup for regular players.
scoreboard players enable @a pvp.trigger
scoreboard players enable @a pvp.request
scoreboard players enable @a pvp.accept
scoreboard players enable @a pvp.decline
scoreboard players enable @a pvp.stats

# #global et #next_id sont des "fake players" (pas de vrais joueurs),
# juste des variables globales pour éviter de dupliquer l'état.
scoreboard players set #global pvp.state 0
scoreboard players add #next_id pvp.state 0

tellraw @a [{"text":"[potatoPVP v1.1] datapack chargé.","color":"dark_gray"}]
