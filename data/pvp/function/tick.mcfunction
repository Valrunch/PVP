# ============================================================
# tick.mcfunction — tourne chaque tick (20x/seconde)
# Chaque bloc ne coute quasi rien tant qu'aucun joueur n'a le
# score correspondant : le "if"/selector sort immediatement.
#
# v1.0 — PERF : les 7 "scoreboard players enable @a ..." qui tournaient
# ICI pour TOUS les joueurs a CHAQUE tick ont ete retires. Un trigger
# vanilla reste actif tant qu'il n'a pas ete consomme : le reactiver en
# boucle 20x/seconde ne servait a rien. Il est maintenant active une
# seule fois a la connexion (assign_id.mcfunction) et reactive juste
# apres consommation, uniquement pour le joueur concerne (blocs
# ci-dessous). pvp.accept / pvp.decline n'ont pas besoin de ce
# traitement : ils sont deja reactives, cibles, par
# send_request_notify.mcfunction des qu'une demande arrive.
# ============================================================

# --- Attribution paresseuse d'un ID unique (couvre les nouvelles connexions) ---
execute as @a unless score @s pvp.id matches 1.. run function pvp:assign_id

# --- Ouverture du menu principal (GUI) ---
execute as @a[scores={pvp.trigger=1..}] run menu pvp:main
execute as @a[scores={pvp.trigger=1..}] run scoreboard players enable @s pvp.trigger
execute as @a[scores={pvp.trigger=1..}] run scoreboard players set @s pvp.trigger 0

# --- Envoi d'une demande de duel ciblee ---
execute as @a[scores={pvp.request=1..}] run function pvp:send_request
execute as @a[scores={pvp.request=1..}] run scoreboard players enable @s pvp.request
execute as @a[scores={pvp.request=1..}] run scoreboard players set @s pvp.request 0

# --- Reponse a une demande recue (accepter / refuser) ---
# pvp.accept / pvp.decline : pas de "enable" ici, deja gere par
# send_request_notify.mcfunction au moment ou la demande arrive.
execute as @a[scores={pvp.accept=1..}] run function pvp:accept_request
execute as @a[scores={pvp.accept=1..}] run scoreboard players set @s pvp.accept 0
execute as @a[scores={pvp.decline=1..}] run function pvp:decline_request
execute as @a[scores={pvp.decline=1..}] run scoreboard players set @s pvp.decline 0

# --- Annulation d'une demande envoyee ---
execute as @a[scores={pvp.cancel=1..}] run function pvp:cancel_request
execute as @a[scores={pvp.cancel=1..}] run scoreboard players enable @s pvp.cancel
execute as @a[scores={pvp.cancel=1..}] run scoreboard players set @s pvp.cancel 0

# --- Aide (liste des commandes) ---
execute as @a[scores={pvp.help=1..}] run function pvp:help
execute as @a[scores={pvp.help=1..}] run scoreboard players enable @s pvp.help
execute as @a[scores={pvp.help=1..}] run scoreboard players set @s pvp.help 0

# --- Stats persos ---
execute as @a[scores={pvp.stats=1..}] run function pvp:show_stats
execute as @a[scores={pvp.stats=1..}] run scoreboard players enable @s pvp.stats
execute as @a[scores={pvp.stats=1..}] run scoreboard players set @s pvp.stats 0

# --- Expiration auto d'une demande non traitee (30s = 600 ticks) ---
# Evite qu'une cible qui ignore une demande bloque le systeme pour tout
# le monde indefiniment (le requester ne pourrait plus rien envoyer).
execute as @a[scores={pvp.pending_from=1..,pvp.pendingticks=1..}] run scoreboard players remove @s pvp.pendingticks 1
execute as @a[scores={pvp.pending_from=1..,pvp.pendingticks=..0}] run function pvp:expire_request

# --- Nettoyage des duels fantomes apres un bug ou un tp casse ---
# Si un joueur porte encore le tag pvp.duel alors qu'il n'est plus dans
# la dimension du duel, on le remet au propre pour eviter qu'il soit
# bloque indefiniment comme "en duel".
execute as @a[tag=pvp.duel] unless data entity @s {Dimension:"multiworld:pvp"} run function pvp:cleanup_player
execute unless entity @a[tag=pvp.duel] if score #global pvp.state matches 1..2 run scoreboard players set #global pvp.state 0

# --- Suivi d'un duel en cours (decompte ET combat) ---
# matches 1..2 : 1 = combat, 2 = decompte. Couvrir le decompte aussi
# permet de detecter une deconnexion pendant les 3-2-1 sans attendre
# le debut du combat pour reagir.
execute if score #global pvp.state matches 1..2 run function pvp:check_win
